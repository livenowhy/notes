## jenkins plugins
    
    注意:离线安装版本问题，否则不可以使用

    下载特定版本的插件: https://updates.jenkins-ci.org/download/plugins
    
    
    ccb jenkins 2.303.2

### requests
    
    https://plugins.jenkins.io/http_request/

    特定版本: https://updates.jenkins-ci.org/download/plugins/http_request/1.16/http_request.hpi


### pipeline-utility-steps

    特定版本: https://updates.jenkins-ci.org/download/plugins/pipeline-utility-steps/2.8.0/pipeline-utility-steps.hpi

    支持的方法清单如下:
    compareVersions:    Compare two version number strings
    findFiles:          Find files in the workspace
    nodesByLabel:       List of nodes by Label, by default excludes offline nodes.
    readCSV:            Read content from a CSV file in the workspace.
    readJSON:           Read JSON from files in the workspace.
    readManifest:       Read a Jar Manifest
    readMavenPom:       Read a maven project file.
    readProperties:     Read properties from files in the workspace or text.
    readYaml:           Read yaml from files in the workspace or text.
    sha1:               Compute the SHA1 of a given file
    sha256:             Compute the SHA256 of a given file
    tee:                Tee output to file
    touch:              Create a file (if not already exist) in the workspace, and set the timestamp
    unzip:              Extract Zip file
    writeCSV:           Write content to a CSV file in the workspace.
    writeJSON:          Write JSON to a file in the workspace.
    writeMavenPom:      Write a maven project file.
    writeYaml:          Write a yaml from an object or objects.
    zip:                Create Zip file


### jar 包
    
    ./jenkins/war/WEB-INF/lib
    https://mvnrepository.com/artifact/redis.clients/jedis/4.1.1