python -m venv potato_env
py -m pip install -r requirements.txt

REM  eval $(ssh-agent -s) && ssh-add "C:\Users\NAME\.ssh\personal_github"
REM pip freeze --all > requirements.txt
REM pyinstaller -F one_microphone.py