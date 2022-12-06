terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//resource_group?ref=v0.7.19"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  resource_group_name = "mdu_students_pulse_project"
  location            = "swedencentral"

  role_assignements = [
    {
      role_name = "Contributor"
      users    = [
        "andreas.karlsson@nv-external.com",
        "balen.alyassin@nv-external.com",
        "petar.tomovic@nv-external.com",
        "kim.holsner@nv-external.com",
        "maria.wiklund@nv-external.com",
        "gina.senewiratne@nv-external.com",
        "mehdi.bel-fdhila@nv-external.com",
        "bahareh.aghajanpour@nv-external.com",
        "chamani.perummuni@nv-external.com",
        ]
    },
  ]
}

