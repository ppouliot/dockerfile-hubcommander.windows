FROM stefanscherer/chocolatey
MAINTAINER peter.pouliot@rakuten.com
ENV SLACK_TOKEN 1122334455667799
RUN choco install python3 wget curl git -y
RUN wget --no-check-certificate https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py
RUN pip install virtualenv virtualenvwrapper-win
RUN md rakslack.bot\plugins
RUN type nul > rakslack.bot\plugins\__init__.py
RUN cd rakslack.bot
RUN mkvirtualenv rakslack.bot
RUN pip install rtmbot
RUN git clone https://github.com/Netflix/hubcommander
RUN pip install .\hubcommander
RUN powershell.exe rm -Force hubcommander\setup.py
RUN powershell.exe rm -Force hubcommander\tests
RUN echo 'DEBUG: True' > rtmbot.conf
RUN echo 'SLACK_TOKEN: "${SLACK_TOKEN}"' >> rtmbot.conf
RUN echo 'ACTIVE_PLUGINS:' >> rtmbot.conf
RUN echo '    - hubcommander.hubcommander.HubCommander' >> rtmbot.conf
