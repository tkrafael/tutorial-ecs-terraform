terraform {
    source = find_in_parent_folders("modules/ecs-cluster")
}
include {
    path = find_in_parent_folders()
}
inputs = {
    cluster_name = "smpp-cluster"
}