# Check your GitLab pipelines from the commandline

## Install

The program is available on PyPi and can be installed via pip:

```sh
$ pip install pipe-stat
```

## Config

This file is needed in order to use the program.

Example config:

```json
{
  "projects": {
    "parallel": 23234375,
    "gitlab": 278964
  },
  "base_url": "https://gitlab.com",
  "access_token": "YOUR-TOKEN"
}
```

The application will look for a file named `.pipe_stat` in your home dir (`~`)  and your current working dir (`pwd`) by
default. This file must be an valid JSON file with the following entries:

- projects: A mapping of <project_name:project_id> (`some_project": 278964`). You can name the project however you
  want. Just remember that the name will be used later when using the program (`pipe-stat some_project`). If you do not
  know your project id, you can get it from your projects GitLab page.
- base_url: The base url of your gitlab instance. E.g. `https://gitlab.com`
- access_token: A valid access token, that you can create on your gitlab site.

## Usage

The following examples are based on the example configuration. So you might need to adjust the commands slightly.

1. Get the last recent pipelines for the project `parallel` (remember that the program will use the name, that you gave
   it in the config file and not the real name):
   ```sh
   $ pipe-stat gitlab
    ╒═══════════════════╤══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╤═════════════════════════════════╤══════════╤═════════╤════════════════╕
    │ Project           │ Commit                                                                                                                   │ Ref                             │ Status   │ Stage   │ Finished       │
    ╞═══════════════════╪══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╪═════════════════════════════════╪══════════╪═════════╪════════════════╡
    │ gitlab-org/gitlab │ Merge branch '295240-saved-scans-routes' into 'master'                                                                   │ master                          │ running  │ pages   │ -              │
    ├───────────────────┼──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┼─────────────────────────────────┼──────────┼─────────┼────────────────┤
    │ gitlab-org/gitlab │ Merge branch 'fix-vuln-helper' into 'master'                                                                             │ refs/merge-requests/50648/merge │ running  │ post-qa │ -              │
    ├───────────────────┼──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┼─────────────────────────────────┼──────────┼─────────┼────────────────┤
    │ gitlab-org/gitlab │ Refactor pages migration services                                                                                        │ refs/merge-requests/50624/head  │ running  │ post-qa │ -              │
    ├───────────────────┼──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┼─────────────────────────────────┼──────────┼─────────┼────────────────┤
    │ gitlab-org/gitlab │ Merge branch '295241-saved-scans-fields' into 'master'                                                                   │ refs/merge-requests/50550/merge │ running  │ post-qa │ -              │
    ├───────────────────┼──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┼─────────────────────────────────┼──────────┼─────────┼────────────────┤
    │ gitlab-org/gitlab │ Fix gitlab pot                                                                                                           │ refs/merge-requests/50180/head  │ running  │ post-qa │ -              │
    ├───────────────────┼──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┼─────────────────────────────────┼──────────┼─────────┼────────────────┤
    │ gitlab-org/gitlab │ Refactor pages migration services                                                                                        │ refs/merge-requests/50624/head  │ canceled │ post-qa │ 18 minutes ago │
    ├───────────────────┼──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┼─────────────────────────────────┼──────────┼─────────┼────────────────┤
    │ gitlab-org/gitlab │ Merge branch 'fix-vuln-helper' into 'master'                                                                             │ refs/merge-requests/50648/merge │ canceled │ post-qa │ 17 minutes ago │
    ├───────────────────┼──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┼─────────────────────────────────┼──────────┼─────────┼────────────────┤
    │ gitlab-org/gitlab │ Merge branch '295241-saved-scans-fields' into 'master'                                                                   │ refs/merge-requests/50550/merge │ canceled │ post-qa │ 20 minutes ago │
    ├───────────────────┼──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┼─────────────────────────────────┼──────────┼─────────┼────────────────┤
    │ gitlab-org/gitlab │ Merge branch 'scalability/665-create-introductory-documentation-and-tutorial-about-stage-group-dashboards' into 'master' │ refs/merge-requests/50570/merge │ success  │ review  │ 34 minutes ago │
    ├───────────────────┼──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┼─────────────────────────────────┼──────────┼─────────┼────────────────┤
    │ gitlab-org/gitlab │ Merge branch 'scalability/665-create-introductory-documentation-and-tutorial-about-stage-group-dashboards' into 'master' │ refs/merge-requests/50570/merge │ success  │ review  │ 42 minutes ago │
    ╘═══════════════════╧══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╧═════════════════════════════════╧══════════╧═════════╧════════════════╛
   ```
   
2. Get the most recent failed pipelines for the project `parallel`:
   ```sh
   $ pipe-stat gitlab -s failed
    ╒═══════════════════╤═══════════════════════════════════════════════════════════════════════╤═════════════════════════════════╤══════════╤═════════╤════════════════╕
    │ Project           │ Commit                                                                │ Ref                             │ Status   │ Stage   │ Finished       │
    ╞═══════════════════╪═══════════════════════════════════════════════════════════════════════╪═════════════════════════════════╪══════════╪═════════╪════════════════╡
    │ gitlab-org/gitlab │ Use getters for derived props for epics                               │ refs/merge-requests/50616/head  │ failed   │ post-qa │ 41 minutes ago │
    ├───────────────────┼───────────────────────────────────────────────────────────────────────┼─────────────────────────────────┼──────────┼─────────┼────────────────┤
    │ gitlab-org/gitlab │ Spike/Proof of Concept for snippets recaptcha                         │ refs/merge-requests/50559/head  │ failed   │ post-qa │ an hour ago    │
    ├───────────────────┼───────────────────────────────────────────────────────────────────────┼─────────────────────────────────┼──────────┼─────────┼────────────────┤
    │ gitlab-org/gitlab │ WIP                                                                   │ refs/merge-requests/50624/head  │ failed   │ post-qa │ 2 hours ago    │
    ├───────────────────┼───────────────────────────────────────────────────────────────────────┼─────────────────────────────────┼──────────┼─────────┼────────────────┤
    │ gitlab-org/gitlab │ Create vuex getters for roadmap item dates                            │ refs/merge-requests/50616/head  │ failed   │ post-qa │ 2 hours ago    │
    ├───────────────────┼───────────────────────────────────────────────────────────────────────┼─────────────────────────────────┼──────────┼─────────┼────────────────┤
    │ gitlab-org/gitlab │ Merge branch 'add_board_type' into 'master'                           │ refs/merge-requests/50412/merge │ failed   │ post-qa │ 2 hours ago    │
    ├───────────────────┼───────────────────────────────────────────────────────────────────────┼─────────────────────────────────┼──────────┼─────────┼────────────────┤
    │ gitlab-org/gitlab │ Spike/Proof of Concept for snippets recaptcha                         │ refs/merge-requests/50559/head  │ failed   │ post-qa │ 3 hours ago    │
    ├───────────────────┼───────────────────────────────────────────────────────────────────────┼─────────────────────────────────┼──────────┼─────────┼────────────────┤
    │ gitlab-org/gitlab │ Merge branch 'epic_boards_epic_list' into 'master'                    │ refs/merge-requests/50277/merge │ failed   │ post-qa │ 4 hours ago    │
    ├───────────────────┼───────────────────────────────────────────────────────────────────────┼─────────────────────────────────┼──────────┼─────────┼────────────────┤
    │ gitlab-org/gitlab │ Refactor temp2                                                        │ refs/merge-requests/50616/head  │ failed   │ post-qa │ 4 hours ago    │
    ├───────────────────┼───────────────────────────────────────────────────────────────────────┼─────────────────────────────────┼──────────┼─────────┼────────────────┤
    │ gitlab-org/gitlab │ Merge branch 'qa-shl-fix-project-export-audit-log-spec' into 'master' │ refs/merge-requests/50644/merge │ failed   │ post-qa │ 2 hours ago    │
    ├───────────────────┼───────────────────────────────────────────────────────────────────────┼─────────────────────────────────┼──────────┼─────────┼────────────────┤
    │ gitlab-org/gitlab │ Merge branch '30390-duplicate-group-label' into 'master'              │ refs/merge-requests/37148/merge │ failed   │ post-qa │ 5 hours ago    │
    ╘═══════════════════╧═══════════════════════════════════════════════════════════════════════╧═════════════════════════════════╧══════════╧═════════╧════════════════╛
    ```
   
3. Get the most recent succeeded pipeline:
   ```sh
   $ pipe-stat gitlab -s success -n 1
    ╒═══════════════════╤══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╤═════════════════════════════════╤══════════╤═════════╤════════════════╕
    │ Project           │ Commit                                                                                                                   │ Ref                             │ Status   │ Stage   │ Finished       │
    ╞═══════════════════╪══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╪═════════════════════════════════╪══════════╪═════════╪════════════════╡
    │ gitlab-org/gitlab │ Merge branch 'scalability/665-create-introductory-documentation-and-tutorial-about-stage-group-dashboards' into 'master' │ refs/merge-requests/50570/merge │ success  │ review  │ 39 minutes ago │
    ╘═══════════════════╧══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╧═════════════════════════════════╧══════════╧═════════╧════════════════╛
   ```

4. Get currently running pipelines:
   ```sh
    $ pipe-stat gitlab -s running
    ╒═══════════════════╤════════════════════════════════════════════════════════╤═════════════════════════════════╤══════════╤═════════╤════════════╕
    │ Project           │ Commit                                                 │ Ref                             │ Status   │ Stage   │ Finished   │
    ╞═══════════════════╪════════════════════════════════════════════════════════╪═════════════════════════════════╪══════════╪═════════╪════════════╡
    │ gitlab-org/gitlab │ Remove security_on_demand_scans_site_validation FF     │ refs/merge-requests/50635/head  │ running  │ post-qa │ -          │
    ├───────────────────┼────────────────────────────────────────────────────────┼─────────────────────────────────┼──────────┼─────────┼────────────┤
    │ gitlab-org/gitlab │ Merge branch '295240-saved-scans-routes' into 'master' │ master                          │ running  │ pages   │ -          │
    ├───────────────────┼────────────────────────────────────────────────────────┼─────────────────────────────────┼──────────┼─────────┼────────────┤
    │ gitlab-org/gitlab │ Merge branch 'fix-vuln-helper' into 'master'           │ refs/merge-requests/50648/merge │ running  │ post-qa │ -          │
    ├───────────────────┼────────────────────────────────────────────────────────┼─────────────────────────────────┼──────────┼─────────┼────────────┤
    │ gitlab-org/gitlab │ Refactor pages migration services                      │ refs/merge-requests/50624/head  │ running  │ post-qa │ -          │
    ├───────────────────┼────────────────────────────────────────────────────────┼─────────────────────────────────┼──────────┼─────────┼────────────┤
    │ gitlab-org/gitlab │ Merge branch '295241-saved-scans-fields' into 'master' │ refs/merge-requests/50550/merge │ running  │ post-qa │ -          │
    ╘═══════════════════╧════════════════════════════════════════════════════════╧═════════════════════════════════╧══════════╧═════════╧════════════╛
   ```

5. Use a non-default configuration file:
   ```sh
    $ pipe-stat parallel -f ./pipe_stat 
    $ # or
    $ pipe-stat parallel -f ~/Downloads/some_file
   ```