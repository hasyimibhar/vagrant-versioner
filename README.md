## Dependencies

```sh
gem install thor
gem install json
```

## Usage

Create a new empty box metadata:

```sh
./vagrant-versioner.rb create mybox.box \
	--name "mycompany/mybox" \
	--description "This is an awesome box"
```

```json
{
  "name": "mycompany/mybox",
  "description": "This is an awesome box",
  "versions": [

  ]
}
```

Add version to metadata:

```sh
./vagrant-versioner.rb version mybox.box \
	--version "0.1.0" \
	--url "http://mycompany.com/boxes/mybox-0.1.0.box" \
	--checksum-type "sha1" \
	--checksum "4cf79548b1353c0fc92f0665109129f51aafa2bd"
```

```json
{
  "name": "mycompany/mybox",
  "description": "This is an awesome box",
  "versions": [
    {
      "version": "0.1.0",
      "providers": [
        {
          "name": "virtualbox",
          "url": "http://mycompany.com/boxes/mybox-0.1.0.box",
          "checksum_type": "sha1",
          "checksum": "4cf79548b1353c0fc92f0665109129f51aafa2bd"
        }
      ]
    }
  ]
}
```

## Suggestion

Use it along with [vagrants3-auth](https://github.com/WhoopInc/vagrant-s3auth) plugin to host your boxes on private S3. 
Combined with some automation (e.g. [Jenkins](http://jenkins-ci.org)), you can have your own Vagrant cloud to privately 
share Vagrant boxes with your colleagues.
