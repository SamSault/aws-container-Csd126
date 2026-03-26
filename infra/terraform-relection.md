1.	Import blocks allow terraform to take control of existing resources instead of creating new ones. They work by linking a resource from your real resource into your code and storing it with them terraform would just create new resources automatically.
2.	Terraform track infrastructures using state files with store resource datils.
We do not use terraform to manage the secrets stores in the parameter tore service because secret and state can be often shared and exposed increasing security risk.
It is would be okay to use when the state is securely encrypted and well under control
