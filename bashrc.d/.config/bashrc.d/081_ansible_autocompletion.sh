# unbuntu 22.04 는 register-python-argcomplete3 이고 그 이후는 register-python-argcomplete 라서
# 둘 다 작동하도록 처리
if command -v register-python-argcomplete3 &> /dev/null
then
    alias register-python-argcomplete=register-python-argcomplete3
fi

eval "$(register-python-argcomplete ansible)"
eval "$(register-python-argcomplete ansible-config)"
eval "$(register-python-argcomplete ansible-console)"
eval "$(register-python-argcomplete ansible-doc)"
eval "$(register-python-argcomplete ansible-galaxy)"
eval "$(register-python-argcomplete ansible-inventory)"
eval "$(register-python-argcomplete ansible-playbook)"
eval "$(register-python-argcomplete ansible-pull)"
eval "$(register-python-argcomplete ansible-vault)"
