# Flutter clean architecture sample

 - Clean architecture with SOLID principals
 - Developed under test driven development
 - Blocs has been used for state management
 - Includes unit tests, widget tests, integration tests and CI/CD

# File Structure

```bash
 lib
 ├── core
 │   ├── error
 │   │   ├── exceptions.dart
 │   │   └── failures.dart
 │   ├── network
 │   │   ├── network_info.dart
 │   │   ├── rest_client_service.chopper.dart
 │   │   └── rest_client_service.dart
 │   ├── usecases
 │   │   ├── fetch_token.dart
 │   │   └── usecase.dart
 │   ├── utils
 │   │   ├── constants.dart
 │   │   ├── router.dart
 │   │   └── theme.dart
 │   └── widgets
 │       └── custom_snak_bar.dart
 ├── injection_container.dart
 ├── main.dart
 └── screens
     ├── change_password
     │   ├── data
     │   │   ├── datasources
     │   │   │   ├── change_password_local_datasource.dart
     │   │   │   └── change_password_remote_datasource.dart
     │   │   └── repositories
     │   │       └── change_password_repository_impl.dart
     │   ├── domain
     │   │   ├── repositories
     │   │   │   └── change_password_repository.dart
     │   │   └── usecases
     │   │       └── change_password.dart
     │   └── presentation
     │       ├── blocs
     │       │   └── change_password
     │       │       ├── bloc.dart
     │       │       ├── change_password_bloc.dart
     │       │       ├── change_password_event.dart
     │       │       └── change_password_state.dart
     │       └── page
     │           └── change_password.dart
     ├── home
     │   ├── data
     │   │   ├── datasources
     │   │   │   ├── home_local_datasource.dart
     │   │   │   └── home_remote_datasource.dart
     │   │   └── repositories
     │   │       └── home_repository_impl.dart
     │   ├── domain
     │   │   ├── repositories
     │   │   │   └── home_repository.dart
     │   │   └── usecases
     │   │       └── logout_user.dart
     │   └── presentation
     │       ├── blocs
     │       │   └── log_out
     │       │       ├── bloc.dart
     │       │       ├── log_out_bloc.dart
     │       │       ├── log_out_event.dart
     │       │       └── log_out_state.dart
     │       └── page
     │           └── home.dart
     └── login
         ├── data
         │   ├── datasources
         │   │   ├── login_local_datasource.dart
         │   │   └── login_remote_datasource.dart
         │   ├── models
         │   │   ├── login_model.dart
         │   │   └── login_model.g.dart
         │   └── repositories
         │       └── login_repository_impl.dart
         ├── domain
         │   ├── entities
         │   │   └── login.dart
         │   ├── repositories
         │   │   └── login_repository.dart
         │   └── usecases
         │       └── login_user.dart
         └── presentation
             ├── blocs
             │   └── user_login
             │       ├── bloc.dart
             │       ├── user_login_bloc.dart
             │       ├── user_login_event.dart
             │       └── user_login_state.dart
             └── page
                 └── login.dart
```


# File structure for tests

```bash
 test
 ├── core
 │   ├── network
 │   │   └── network_info_test.dart
 │   └── usecases
 │       └── fetch_token_test.dart
 ├── fixtures
 │   ├── fixture_reader.dart
 │   ├── user_login.json
 │   └── user_login_null_token.json
 └── screens
     ├── change_password
     │   ├── data
     │   │   ├── datasources
     │   │   │   └── change_password_remote_datasource_test.dart
     │   │   └── repositories
     │   │       └── change_password_repository_impl_test.dart
     │   ├── domain
     │   │   └── usecases
     │   │       └── change_password_test.dart
     │   └── presentation
     │       └── blocs
     │           └── change_password
     │               └── change_password_bloc_test.dart
     ├── home
     │   ├── data
     │   │   ├── datasources
     │   │   │   ├── home_local_datasource_test.dart
     │   │   │   └── home_remote_datasource_test.dart
     │   │   └── repositories
     │   │       └── home_repository_impl_test.dart
     │   ├── domain
     │   │   └── usecases
     │   │       └── logout_user_test.dart
     │   └── presentation
     │       └── blocs
     │           └── log_out
     │               └── log_out_bloc_test.dart
     └── login
         ├── data
         │   ├── datasources
         │   │   ├── login_local_datasource_test.dart
         │   │   └── login_remote_datasource_test.dart
         │   ├── models
         │   │   └── login_model_test.dart
         │   └── repositories
         │       └── login_repository_impl_test.dart
         ├── domain
         │   └── usecases
         │       └── login_user_test.dart
         └── presentation
             └── blocs
                 └── user_login
                     └── user_login_bloc_test.dart
```