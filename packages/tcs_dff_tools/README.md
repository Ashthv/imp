
## Getting started

Tools section contains various tools used for developer productivity
1. Code generation
2. Manage pub dependency using pub_manager

## Usage for Codegen tool
Code generation for view, api and store classes. The tools is used for create boiler plate code for view, api and store for new feature/sub feature development. 
Individual has to configure the specification file to use it. Once the code is generated, anyone can modidy it. It should be used once for a feature. Running the command multiple times will override existing files. So once you create then dont run it again for same feature. 

Provide required input file

```Command to generate code from anywhere
dart pub global activate -sgit http://10.10.245.133:443/tcs_sbi_yono/tcs_dff_flutter.git --git-path packages/tcs_dff_tools/ --git-ref main
Replace the IP address based on the env where framework is hosted.
dart pub global run tcs_dff_tools:codegen <file path to json input specification e.g default_specification.json in framework>
```
or

```Command to generate code from tcs_dff_flutter repo
melos generate_code <file path to json input specification>
```

If you want to deactivate the codegen 
```
dart pub global deactivate tcs_dff_tools
```

Specification json file. Read the comments inline for each params. Sample file is kept in "input" folder within tools package
```
{
  "featureSpec":{
    "featureName":"starter_kit_demo", // name of the feature. a folder will be created by this name 
    "outputPath":"/Users/a843010/Documents/projects/SBI-YONO/tcs_dff_flutter/tcs_dff_flutter/features/home/lib/" // location where to create the folders
  },
  "viewSpec":{ // specification for view classes
    "className":"UILogin", // name of the class
    "stateLess":true // boolean to create stateless(true) or stateful(false) widget
  },
  "apiSpec":{
    "className":"Login", // name of the class
    "apiFunction": { // api functiond details
      "functionName":"doUserLogin",
      "functionParams":[{ // list of function params with types
        "type":"String",
        "name":"userName"
     }],
     "returnObject":"LoginResponse" // expected response object
    },
    "url":"/dologin" // api url. dont include base url
  },
  "storeSpec": { // specification for api classes
    "className":"Login", // name of the store class
    "storeFunction":{ // function spec within store
      "functionName":"doUserLogin",// name of the function
      "observers":[{ // list of observers
        "type":"String",
        "name":"example"
     }],
      "functionParams":[{ // list of function params
        "type":"LoginAPI",
        "name":"api"
     },{
        "type":"bool",
        "name":"isLogin"
     }]
    },
    "apiFunctionCall":"doLogin" // api call within store function. this should ideally match the function name in spec
  }
  

}
```


## Pub Manager helps in managing pub dependency
It provides various commands like list, update or outdated 
1. list - It will list down all unique dependency within the project. Using this command will create a yaml file which can be used to update dependencies
2. update - It is to update dependency. By providing a yaml file with dependency which needs to be updated across the project, it will update in all pubspec file. 
Note: Ensure you run the app once after running the update command.
3. outdated - It create file with outdated dependencies within the project. It runs 'flutter pub outdated' for each flutter project and creates 2 files. one json with all outdated dependency output from the command and another a yaml file with dependency name and latest version. This will help in case we want to use update command to update all dependency to the latest version.

Command to list/update/outdated dependency from root of the project
First activate tools package to run various commands.
```
dart pub global activate -sgit http://10.10.245.133:443/tcs_sbi_yono/tcs_dff_flutter.git --git-path packages/tcs_dff_tools/ --git-ref main
```
Replace the IP address based on the env where framework is hosted.

To list dependencies
```
pub_manager list <root_dir>
```
It will create file "pubspec_collection.yaml" in root directory will all unique dependency from project

To update dependency
```
pub_manager update <root_dir> <yaml_file for update command only>
```

Get outdated with upgradable version
```
pub_manager outupgrade <root_dir>
``` 
or

Get outdated with resolvable version. 
Note: resolveable version is higher then upgradable
```
pub_manager outresolve <root_dir>
```
Above command will update/list all dependencies provided in yaml file in all the projects.

If you want to deactivate the pub_manager 
```
dart pub global deactivate tcs_dff_tools
```