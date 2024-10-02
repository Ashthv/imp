This package help to achieve storing of data into the secondary storage.The data store into this storage is permanant.The NoSQL database provided by this package. The data store in the Key & Value farmat.

## Features
This package provides the following feature
1. Save & update data into the database
2. Get the data from the database
3. Delete the data from the database
4. Store the data into encrpted format

## Getting started
To access the package methods, you have to create the instance of HiveStorage, the instance creation example provided into the demo app. While creating instance it takes two option parameter
1. initFunction - which take the function as parameter i.e. used to initalise(creating) the storage path, if you don't provide the init function it will take default function as Flutter initailisation.
2. securedKey - which take the list of integer value as parameter, this secured key used for the encrpt your database.If user don't provide the value, by default it generate the key using Hive storage method to encrpt database.

## Usage

Following are the methods provided by storage package

```dart
1.  Future<void> setItem<T>({
    required final String collectionName,
    required final String key,
    required final T item,
  });
```
This method used to save or update the data into the database.

```collectionName```- used to provide the name of the collection which is same as table in the SQL database.Inside this collection your data will be store in key & value format.
```key``` - Key is string value which is unique.This is used to save & retrieve data from the database collection
```item``` -  The data which you wants to store.

```dart
2. Future<void> setSecuredItem<T>({
    required final String collectionName,
    required final String key,
    required final T item,
  });

```
This method to used to store data into the encrpted format.

```dart
3.Future<T?> getItem<T>({
    required final String collectionName,
    required final String key,
  });
```
This method used to get the data from the database.

```dart
4. Future<T?> getSecuredItem<T>({
    required final String collectionName,
    required final String key,
  });
```
This method is used to get the secured (which stored in the encrpted format) data from the database.

```dart
5. Future<Map<String, T>> getAllItems<T>({
    required final String collectionName,
    required final List<String> keys,
  });
```
This method used to get multiple data item stored in the single collection.Here you need to provide list of Key & name of the collection where data is stored.

```dart
6. Future<Map<String, T>> getAllSecuredItems<T>({
    required final String collectionName,
    required final List<String> keys,
  });
```
This method used to get multiple items stored in encrpted format previously.

```dart
7. Future<void> deleteItem<T>({
    required final String collectionName,
    required final String key,
  });
```
This method is used to delete the item from the database collection.

```dart
8. Future<void> deleteAllItems<T>({
    required final String collectionName,
    required final List<String> keys,
  });
```
This method used to delete the multiple items from the database collection.

```dart
9. Future<void> clearCollection<T>({required final String collectionName});
```
This method used to clear all the data from the database collection.

```dart
10. Future<void> closeCollection<T>({required final String collectionName});
```
This method used to close the collection which is opened previously to perform various operation into the database.

## Additional information
Following are method yet to be implemented:
- setSecuredItem
- getSecuredItem
- getAllSecuredItems

