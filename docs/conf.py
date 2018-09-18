import sys
import os
import shlex

import recommonmark
from recommonmark.parser import CommonMarkParser
from recommonmark.transform import AutoStructify

# for Sphinx-1.4 or newer
extensions = ['recommonmark']

# for Sphinx-1.3
from recommonmark.parser import CommonMarkParser

source_parsers = {
    '.md': CommonMarkParser,
}

source_suffix = ['.rst', '.md']

source_parsers = {
   '.md': 'recommonmark.parser.CommonMarkParser',
}

github_doc_root = 'https://github.com/ProjectPODER/ManualKibanaOCDS/tree/master/docs/'


def setup(app):
    app.add_config_value('recommonmark_config', {
        'url_resolver': lambda url: github_doc_root + url,
        'auto_toc_tree_section': 'Contents',
        'enable_eval_rst': True,
        'enable_auto_doc_ref': True,
    }, True)
    app.add_transform(AutoStructify)
