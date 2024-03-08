# Android App Version Increment ➕

[![My Skills](https://skillicons.dev/icons?i=githubactions,gradle,androidstudio&perline=3)](https://skillicons.dev)

## Use 📄

### Example ⌨️

```yaml
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Update version
        uses: abhishek-3289/android-version-increment@v1
        with:
          increment-type: patch
          update-release-notes: true
          
      - name: Commit and Push Changes
        run: |
          git commit -am "Update version"
          git push origin master
```


### Description 🔖

This action will fetch the current latest _normal_ semantic version (semver) from the tags in
a git repository.  It will increment the version as directed (by default: +1 to
the patch digit). A gradle command will be executed to update android application version for major.minor.patch and buildMeta. 
Plugin for android versioning https://plugins.gradle.org/plugin/net.thauvin.erik.gradle.semver.

```groovy
tasks.register('updateReleaseNotesVersion') {
    doFirst {
        def version = "v${semver.major}.${semver.minor}.${semver.patch}"
        ant.replaceregexp(match: '^v\\d+.\\d+.\\d+', replace: version, flags: 's', byline: false) {
            fileset(dir: '<dir/path>', includes: '**/*.txt')
        }
    }
}
```

### Inputs 📥

| name                    | description                                                                                                                                       | required | default  |
|:------------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------| :---     | :---     |
| increment-type          | The digit to increment, either `major`, `minor` or `patch`.                                                                                       | No       | `patch` |
| update-release-notes    | Set to `true` for updating release notes; This will execute gradle task `updateReleaseNotesVersion` which can be added into your android project. | No       | `false`  |
| github-token            | The GitHub token used to authenticate when submitting via the Dependency Submission API.                                                          | No       | `github.token`  |

### Outputs

1. **latest-tag** :- Latest tag or default `v0.0.0` if tag does not exist.
2. **tag-version** :- Tag version without `v` eg: `1.0.0`.
3. **new-version** :- Incremented version.
4. **new-version-major** :- Incremented major version.
5. **new-version-minor** :- Incremented minor version.
6. **new-version-patch** :- Incremented patch version.