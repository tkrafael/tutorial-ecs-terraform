terraform {
    source = find_in_parent_folders("modules/service")
}
include {
    path = find_in_parent_folders()
}
dependency cluster {
    config_path = find_in_parent_folders("cluster")
}
inputs = {
    clusters = [dependency.cluster.outputs.cluster_name]
    service_name = "myawesomeservice"
}
dependencies {
    paths = [find_in_parent_folders("task-definition")]
}