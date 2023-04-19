terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//role_definitions?ref=v0.7.50"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/role_definitions/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  role_definitions = [
    {
      name              = "NV-AzureStreamAnalytics"
      description       = "Provides access to Stream Analytics, as defined at https://docs.microsoft.com/en-gb/azure/event-hubs/process-data-azure-stream-analytics"
      subscription_name = "nv-d365-dev"
      permissions = [
        {
          actions = [
            "Microsoft.StreamAnalytics/locations/CompileQuery/action",
            "Microsoft.StreamAnalytics/locations/SampleInput/action",
            "Microsoft.StreamAnalytics/locations/TestQuery/action",
            "Microsoft.StreamAnalytics/locations/operationresults/Read"
          ]
        }
      ],
    },
  ]
}

