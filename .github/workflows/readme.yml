# This workflow generates READMEs for all languages

name: Ronbun

on: 
  push:
    branches:
      - 'main'
  schedule:
    - cron: 0 0 * * 0

jobs:
  readme:
    name: "README Generation"
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v2
      with:
        submodules: recursive
    
    - name: Set up Python 3.9
      uses: actions/setup-python@v2
      with:
        python-version: 3.9
        
    - name: Install Dependencies
      run: |
        python -m pip install --upgrade pip
        if [ -f requirements.txt ]; then pip install -r requirements.txt; fi
        
    - name: Generate READMEs
      run: ronbun archive/ --log=DEBUG
        
    - name: Commit READMEs
      uses: EndBug/add-and-commit@v7 
      with:
        message: |
          Generated READMEs from sources using Ronbun
          
          
          on-behalf-of: @TheRenegadeCoder <jeremy.grifski@therenegadecoder.com>
        author_name: Jeremy Grifski
        author_email: jeremy.grifski@therenegadecoder.com
