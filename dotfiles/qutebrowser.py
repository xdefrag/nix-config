# pylint: disable=C0111
from qutebrowser.config.configfiles import ConfigAPI  # noqa: F401
from qutebrowser.config.config import ConfigContainer  # noqa: F401

config = config  # type: ConfigAPI # noqa: F821 pylint: disable=E0602,C0103
c = c  # type: ConfigContainer # noqa: F821 pylint: disable=E0602,C0103

config.source('qutewal.py')  # Load colors from pywal cache

c.spellcheck.languages = ['en-US', 'ru-RU']

c.fonts.default_family = 'Iosevka'
c.fonts.default_size = '12pt'

c.scrolling.bar = 'never'
c.scrolling.smooth = False

c.aliases = {'w': 'session-save', 'q': 'quit', 'wq': 'quit --save'}

c.downloads.location.directory = '~/tmp'
c.downloads.location.remember = False
c.downloads.location.prompt = False
c.downloads.remove_finished = 100

c.messages.timeout = 2000

c.tabs.background = True
c.tabs.favicons.show = 'never'
c.tabs.last_close = 'default-page'
c.tabs.position = 'top'
c.tabs.show = 'multiple'
c.tabs.tooltips = False

c.auto_save.session = True
c.session.lazy_restore = True
c.search.ignore_case = 'smart'
c.content.user_stylesheets = []

c.url.searchengines = {
    "DEFAULT": "https://html.duckduckgo.com/html?q={}",
    "wa": "https://wiki.archlinux.org/index.php?search={}",
    "rym": "https://rateyourmusic.com/search?searchterm={}"
}
c.url.default_page = 'https://xdefrag.dev'
c.url.start_pages = ['https://xdefrag.dev']

c.content.private_browsing = False

c.content.cookies.store = True
c.content.cookies.accept = 'all'

c.content.default_encoding = 'UTF-8';
c.content.autoplay = False
c.content.webgl = False
c.content.canvas_reading = False
c.content.geolocation = False
c.content.media_capture = False
c.content.mouse_lock = False
c.content.ssl_strict = True
c.content.mute = True
c.content.plugins = False
c.content.javascript.enabled = True

config.bind('<Ctrl-R>', 'config-cycle content.user_stylesheets ""')

config.bind(',m', 'spawn mpv {url}')
