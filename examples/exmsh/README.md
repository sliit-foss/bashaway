# Example Script

![Logo](./index.png)

<-- badge1 --> <-- badge2 --> <-- badge3 -->

## What is this 
---
This is a script that automates daily basis tasks. You can do day-today tasks easily with this script.

## How To
---
### Intall

```
cd ~
apt update
git clone https://github.com/examplename/example.git
cd example
chmod +x install.sh
./install.sh
```
### Run it

```
exmsh
```
If you remainder task number

```
exmsh < TaskNumber >
```

### Uninstall

``` 
cd ~/.local/share/example 
./uninstall.sh
```
## Tasks
---
* Update
    * APT   - u1
    * DNF   - u2
    * Yarn  - u3
    * Npm   - u4
    * Deno  - u5
    * Cargo - u6
* Upgrade
    * APT   - ug1
    * DNF   - ug2
    * Yarn  - ug3
    * Npm   - ug4
    * Deno  - ug5
    * Cargo - ug6
* Search
    * APT   - s1
    * DNF   - s2
    * Yarn  - s3
    * Npm   - s3
    * Deno  - s4
    * Cargo - s4
* Install
    * APT   - i1
    * DNF   - i2
    * Yarn  - i3
    * Npm   - i3
    * Deno  - i4
    * Cargo - i5
* Git
    * Create repo   - g1
    * Create branch - g2
    * Push repo - g3
    * Pull repo - g4
* React 
    * Create new project    - r1   
* Angular 
    * Create new project    - ng1
    * Create new component
        * with `spec`   - ng2s
        * without `spec`    - ng2
    * Create new service
        * with `spec`   - ng3s
        * without `spec`    - ng3

## Road map
---
- [ ] Update
    - [ ] APT
    - [ ] DNF
    - [x] Yarn
    - [x] Npm
    - [x] Deno
    - [x] Cargo
- [ ] Upgrade
    - [x] APT
    - [x] DNF
    - [x] Yarn
    - [x] Npm
    - [x] Deno
    - [ ] Cargo
- [x] Search
    - [x] APT
    - [x] DNF
    - [x] Yarn
    - [x] Npm
    - [x] Deno
    - [x] Cargo
- [ ] Install
    - [ ] APT
    - [ ] DNF
    - [x] Yarn
    - [x] Npm
    - [x] Deno
    - [ ] Cargo
- [ ] Git
    - [x] Create repo
    - [ ] Create branch
    - [ ] Push repo
    - [ ] Pull repo
- [x] React 
    - [x] Create new project   
- [x] Angular 
    - [x] Create new project
    - [x] Create new component
        - [x] With `spec`
        - [x] Without `spec`
    - [x] Create new service
        - [x] With `spec`
        - [x] Without `spec`
- [ ] Create `--help`

