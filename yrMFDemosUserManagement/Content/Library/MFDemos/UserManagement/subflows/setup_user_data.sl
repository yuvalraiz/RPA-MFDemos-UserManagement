namespace: MFDemos.UserManagement.subflows
operation:
  name: setup_user_data
  inputs:
    - first_name
    - last_name
    - OU
    - ldap_base
    - email_domain
  python_action:
    use_jython: false
    script: |-
      def execute(first_name,last_name,OU,ldap_base,email_domain):
          full_name=first_name+' '+last_name
          uid=first_name.strip()+'.'+last_name.strip()
          email=uid+'@'+email.email_domain
          dn='uid='+uid+',ou='+OU+','+ldap_base
          return locals()
  outputs:
    - full_name
    - dn
    - uid
  results:
    - SUCCESS
