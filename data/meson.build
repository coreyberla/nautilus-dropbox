install_data('dropbox.desktop', install_dir: applicationsdir)

foreach size : ['16x16', '22x22', '24x24', '32x32', '48x48', '64x64', '256x256']
  install_data(
    'icons' / 'hicolor' / size / 'apps' / 'dropbox.png',
    install_dir: datadir / 'icons' / 'hicolor' / size / 'apps',
  )
endforeach

foreach emblem : ['syncing', 'uptodate', 'unsyncable']
  install_data(
    'emblems' / 'emblem-dropbox-@0@.icon'.format(emblem),
    'emblems' / 'emblem-dropbox-@0@.png'.format(emblem),
    install_dir: emblemdir,
  )
endforeach
