########################################################################################################################
#!!
#! @input group_dn: seperate by,
#!!#
########################################################################################################################
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
    - ldap_modify:
        loop:
          for: "grp_dn in group_dn.split(',')"
          do:
            YuvalRaiz.ldap.actions.ldap_modify:
              - ldap_url: '${ldap_url}'
              - ldap_username: '${ldap_username}'
              - ldap_password:
                  value: '${ldap_password}'
                  sensitive: true
              - dn: '${grp_dn}'
              - attr: member
              - new_value: '${user_dn}'
              - activity: add
          break:
            - FAILURE
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      ldap_modify:
        x: 143
        'y': 130
        navigate:
          78e51e9e-55ef-61e4-8319-8c05827280e2:
            targetId: 12e8c44f-1117-739d-bf25-6910156f294d
            port: SUCCESS
    results:
      SUCCESS:
        12e8c44f-1117-739d-bf25-6910156f294d:
          x: 341
          'y': 133
