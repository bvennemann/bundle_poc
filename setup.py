"""
Setup script for bundle_poc.

This script packages and distributes the associated wheel file(s).
Source code is in ./src/. Run 'python setup.py sdist bdist_wheel' to build.
"""
from setuptools import setup, find_packages

import sys
sys.path.append('./src')

import bundle_poc

setup(
    name="bundle_poc",
    version=bundle_poc.__version__,
    url="https://databricks.com",
    author="bernhard.vennemann@d-one.ai",
    description="my test wheel",
    packages=find_packages(where='./src'),
    package_dir={'': 'src'},
    entry_points={"entry_points": "main=bundle_poc.main:main"},
    install_requires=["setuptools"],
)
