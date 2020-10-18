namespace: MFDemos.UserManagement
flow:
  name: mfdemos_create_user
  inputs:
    - first_name
    - last_name
    - OU
    - second_email:
        required: false
    - manager_dn
    - smax_request_id
  workflow:
    - setup_user_data:
        do:
          MFDemos.UserManagement.subflows.setup_user_data:
            - first_name: '${first_name}'
            - last_name: '${last_name}'
            - OU: '${OU}'
            - ldap_base: "${get_sp('MFDemos.UserManagement.ldap_base')}"
            - email_domain: "${get_sp('MFDemos.UserManagement.email_domain')}"
        navigate:
          - SUCCESS: SUCCESS
  outputs:
    - uid
    - dn
    - email
    - smax_user_id
  results:
    - SUCCESS
extensions:
  graph:
    steps:
      setup_user_data:
        x: 86
        'y': 110
        navigate:
          258059e0-29c8-ed3e-1eec-22dccda06506:
            targetId: 491bc0bf-7b10-62c8-b342-2bd5e5a85c3d
            port: SUCCESS
    results:
      SUCCESS:
        491bc0bf-7b10-62c8-b342-2bd5e5a85c3d:
          x: 504
          'y': 112
