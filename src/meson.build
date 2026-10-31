extension_c_args = [
  '-DHAVE_CONFIG_H',
  '-DDATADIR="@0@"'.format(datadir),
  '-DEMBLEMDIR="@0@"'.format(emblemdir),
]

if get_option('debug_logging')
  extension_c_args += '-DND_DEBUG'
else
  extension_c_args += ['-DG_DISABLE_ASSERT', '-DG_DISABLE_CHECKS']
endif

shared_module(
  'nautilus-dropbox',
  'nautilus-dropbox.c',
  'nautilus-dropbox-hooks.c',
  'dropbox-command-client.c',
  'dropbox-client.c',
  'dropbox-client-util.c',
  'dropbox.c',
  c_args: extension_c_args,
  include_directories: include_directories('..'),
  dependencies: [
    nautilus_dep,
    glib_dep,
    gtk_dep.partial_dependency(compile_args: true, includes: true),
  ],
  install: true,
  install_dir: nautilus_extension_dir,
)
