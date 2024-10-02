SBI Yono Framework

## Getting Started
- Refer this link for more details on melos https://melos.invertase.dev/~melos-latest/getting-started
 
### Installation
```shell
dart pub global activate melos
```
### Bootstrap Project / Pub Get All
```shell
melos bootstrap or melos bs
```

### Run dart analysis
```shell
melos run dart_analyze
```
### Run Dart Code Metrics
```shell
melos run dart_code_metrics
```

### Create feature using codege module
```shell
melos generate_code <file path for specification>
```
To get more details on codegen. Check tools package readme section

### To get codecoverage using flutter coverage tool
```shell
melos run test
melos run cov_genhtml
```
This will first run all the test cases within the project. Then we have to run command to generate lcov and output in html. It will create a coverage_report directory where you can open index.html to view the report