# Settings list: https://qutebrowser.org/doc/help/settings.html

config.source('qutewal.py')  # Load colors from pywal cache

c.fonts.default_family = 'Iosevka Term'
c.fonts.default_size = '12pt'

c.aliases = {'w': 'session-save', 'q': 'quit', 'wq': 'quit --save'}
c.search.ignore_case = 'smart'
c.auto_save.session = True

config.set('content.javascript.enabled', True, 'file://*')
config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.enabled', True, 'qute://*/*')

config.bind('zp', 'open -t https://getpocket.com/edit?url={url}')

