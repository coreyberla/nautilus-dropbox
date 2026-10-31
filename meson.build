project(
  'nautilus-dropbox',
  'c',
  version: '2026.09.28',
  license: 'GPL-3.0-or-later',
  meson_version: '>= 1.0.0',
  default_options: [
    'prefix=/usr',
    'buildtype=debugoptimized',
    'warning_level=1',
  ],
)

gnome = import('gnome')
python = import('python').find_installation('python3', modules: ['docutils', 'gi'])

prefix = get_option('prefix')
bindir = prefix / get_option('bindir')
datadir = prefix / get_option('datadir')
mandir = prefix / get_option('mandir')
applicationsdir = datadir / 'applications'
emblemdir = datadir / 'nautilus-dropbox' / 'emblems'

nautilus_dep = dependency('libnautilus-extension-4', version: '>= 43.rc')
glib_dep = dependency('glib-2.0', version: '>= 2.14.0')
gtk_dep = dependency('gtk4')

nautilus_extension_dir = get_option('nautilus_extension_dir')
if nautilus_extension_dir == ''
  nautilus_extension_dir = nautilus_dep.get_variable(
    pkgconfig: 'extensiondir',
    default_value: prefix / get_option('libdir') / 'nautilus' / 'extensions-4',
  )
endif

rst2man = find_program('rst2man', required: false)
if not rst2man.found()
  rst2man = [python, files('rst2man.py')]
endif

conf = configuration_data()
conf.set_quoted('PACKAGE', meson.project_name())
conf.set_quoted('PACKAGE_NAME', meson.project_name())
conf.set_quoted('PACKAGE_VERSION', meson.project_version())
conf.set_quoted('PACKAGE_STRING', '@0@ @1@'.format(meson.project_name(), meson.project_version()))
conf.set_quoted('VERSION', meson.project_version())
configure_file(output: 'config.h', configuration: conf)

dropbox_script = custom_target(
  'dropbox',
  input: ['dropbox.in', 'build_dropbox.py'],
  output: 'dropbox',
  command: [python, '@INPUT1@', meson.project_version(), applicationsdir, '@INPUT0@', '@OUTPUT@'],
  depend_files: files(
    'data/icons/hicolor/16x16/apps/dropbox.png',
    'data/icons/hicolor/64x64/apps/dropbox.png',
  ),
  build_by_default: true,
  install: true,
  install_dir: bindir,
  install_mode: 'rwxr-xr-x',
)

dropbox_txt = custom_target(
  'dropbox.txt',
  input: 'dropbox.txt.in',
  output: 'dropbox.txt',
  command: [python, files('docgen.py'), meson.project_version(), dropbox_script],
  depend_files: files('AUTHORS'),
  feed: true,
  capture: true,
)

custom_target(
  'dropbox.1',
  input: dropbox_txt,
  output: 'dropbox.1',
  command: [rst2man, '@INPUT@'],
  capture: true,
  build_by_default: true,
  install: true,
  install_dir: mandir / 'man1',
)

subdir('data')
subdir('src')

test(
  'dropbox_test',
  python,
  args: [files('dropbox_test.py')],
  workdir: meson.project_build_root(),
  depends: dropbox_script,
)

gnome.post_install(gtk_update_icon_cache: true)

summary(
  {
    'prefix': prefix,
    'nautilus extension dir': nautilus_extension_dir,
    'emblem dir': emblemdir,
    'debug logging': get_option('debug_logging'),
  },
)
