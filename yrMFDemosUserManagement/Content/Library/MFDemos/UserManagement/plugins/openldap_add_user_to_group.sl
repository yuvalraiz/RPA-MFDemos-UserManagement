namespace: MFDemos.UserManagement.plugins
flow:
  name: openldap_add_user_to_group
  inputs:
    - ldap_url
    - ldap_username
    - ldap_password:
        sensitive: true
    - group_dn
    - user_dn
  workflow:
    - ldap_add:
        do:
          YuvalRaiz.ldap.actions.ldap_add:
            - ldap_url: '${ldap_url}'
            - ldap_username: '${ldap_username}'
            - ldap_password:
                value: '${ldap_password}'
                sensitive: true
            - dn: '${dn}'
            - modlist: "${'''{\n 'objectClass': [b'posixAccount', b'top', b'inetOrgPerson'],\n 'cn': [b'%s'],\n 'displayName': [b'%s'],\n 'gidNumber': [b'%s'],\n 'givenName': [b'%s'],\n 'homeDirectory': [b'/'],\n 'sn': [b'%s'],\n 'uidNumber': [b'%s'],\n 'userPassword': [b'%s'],\n 'uid': [b'%s'],\n 'mail': [b'%s']%s%s\n}''' % (cn,display_name,gid_number,given_name,sn,uid_number,user_password,uid,mail,'' if second_mail is None else \",\\n'postalAddress': [b'\"+second_mail+\"']\",'' if manager_dn is None else \",\\n'manager': [b'\"+manager_dn+\"']\")}"
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      ldap_add:
        x: 167
        'y': 147
        navigate:
          8690ff74-b920-66ab-8dd9-53ff73bfefcb:
            targetId: 12e8c44f-1117-739d-bf25-6910156f294d
            port: SUCCESS
    results:
      SUCCESS:
        12e8c44f-1117-739d-bf25-6910156f294d:
          x: 364
          'y': 135
