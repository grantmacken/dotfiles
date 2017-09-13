import re

from .base import Base
from deoplete.util import load_external_module

current = __file__

load_external_module(__file__, 'sources/data')

from namespace_prefixes import NAMESPACE_PREFIXES


class Source(Base):
    def __init__(self, vim):
        super().__init__(vim)

        self.__pattern = re.compile(r':[^:\s]*$')
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
        # col = (context['complete_position']
        #        if 'complete_position' in context
        #        else context['position'][2]) + 1
        # buf = self.vim.current.buffer
        # deoplete return items:
        # word abbr kind menu ( popup pmenu )
        # + info ( preview )
        return [{
            'word': k,
            'kind': v
        } for (k, v) in NAMESPACE_PREFIXES.items()]

    def get_complete_position(self, context):
        match = self.__pattern.search(context['input'])
        return match.start() if match is not None else -1
