import re

from .base import Base
# from deoplete.util import load_external_module

current = __file__

# load_external_module(__file__, 'sources/data')

values = [
  "http://exist-db.org/xquery/sort",
  "http://exist-db.org/xquery/xqdoc",
  "http://exist-db.org/xquery/range",
  "http://exist-db.org/xquery/securitymanager",
  "http://exist-db.org/xquery/ngram",
  "http://exist-db.org/xquery/httpclient",
  "http://exist-db.org/xquery/transform",
  "http://exist-db.org/xquery/xmldb",
  "http://exist-db.org/xquery/xmldiff",
  "http://www.w3.org/2005/xpath-functions/array",
  "http://www.w3.org/2005/xpath-functions/math",
  "http://exquery.org/ns/restxq",
  "http://expath.org/ns/http-client",
  "http://exist-db.org/xquery/counter",
  "http://exist-db.org/xquery/lucene",
  "http://exist-db.org/xquery/repo",
  "http://exist-db.org/xquery/inspection",
  "http://exist-db.org/xquery/session",
  "http://exist-db.org/xquery/system",
  "http://exist-db.org/xquery/validation",
  "http://www.w3.org/2005/xpath-functions",
  "http://exist-db.org/xquery/request",
  "http://exist-db.org/xquery/sql",
  "http://exist-db.org/xquery/datetime",
  "http://expath.org/ns/zip",
  "http://exquery.org/ns/restxq/exist",
  "http://exist-db.org/xquery/xslfo",
  "http://exist-db.org/xquery/util",
  "http://www.w3.org/2005/xpath-functions/map",
  "http://exist-db.org/xquery/response",
  "http://exist-db.org/xquery/contentextraction",
  "http://exist-db.org/xquery/mail",
  "http://exist-db.org/xquery/file",
  "http://exquery.org/ns/request",
  "http://exist-db.org/xquery/image",
  "http://exist-db.org/xquery/examples",
  "http://exist-db.org/xquery/process",
  "http://exist-db.org/xquery/compression",
  "http://exist-db.org/xquery/scheduler",
  "http://exist-db.org/xquery/math",
  "http://expath.org/ns/crypto",
  "http://exist-db.org/xquery/console"
]


class Source(Base):
    def __init__(self, vim):
        super().__init__(vim)

        self.__pattern = re.compile(r'^htt[^:\s]*$')
        # source attributes
        self.filetypes = ['xquery']
        self.mark = '[xQ]'
        self.matchers = ['matcher_length', 'matcher_full_fuzzy']
        self.name = 'xQuery'
        self.rank = 600
        self.min_pattern_length = 1

    def gather_candidates(self, context):
        # main deoplete method
        # @see {context} in deoplete.txt
        # line = context['position'][1]
        # col = (context['complete_position'h]
        #        if 'complete_position' in context
        #        else context['position'][2]) + 1
        # buf = self.vim.current.buffer
        # deoplete return items:
        # word abbr kind menu ( popup pmenu )
        # + info ( preview )
        return [{
            'word': x,
            'kind': 'URILiteral'
        } for x in values]

    def get_complete_position(self, context):
        match = self.__pattern.search(context['input'])
        return match.start() if match is not None else -1
