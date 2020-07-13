# Settings list: https://qutebrowser.org/doc/help/settings.html

config.source('qutewal.py')  # Load colors from pywal cache

c.fonts.default_family = 'Iosevka'
c.fonts.default_size = '12pt'

c.aliases = {'w': 'session-save', 'q': 'quit', 'wq': 'quit --save'}
c.search.ignore_case = 'smart'
c.auto_save.session = True
c.content.autoplay = False

config.set('content.javascript.enabled', True, 'file://*')
config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.enabled', True, 'qute://*/*')

config.bind(',p', 'open -t https://getpocket.com/edit?url={url}')
config.bind(',m', 'spawn mpv {url}')
