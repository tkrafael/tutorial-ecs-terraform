terraform {
    source = find_in_parent_folders("modules/taskdefinition")
}
include {
    path = find_in_parent_folders()
}
inputs = {
    service_name = "myawesomeservice"
}
dependencies {
    paths = [find_in_parent_folders("global/role")]
}