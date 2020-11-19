# andrewflbarnes

A minimal static website designed to host my CV and contact me.

Footer contains links to common services (GH, contact me, CV, etc.)

### Motivation

I need somewhere to keep track of my CV and this seems like a good enough place to do it (version control, yay) but also means I can host in online.

The downside is it's not easily converatable to PDF/doc formats (maybe I'll change thatat some point...).

### Local deployment

Run the build script (pretty sure I don't need this anymore!) then open static/index.html in your favourite browser - simples :)

```bash
make
```

Available receipes are
- build - (default) moves source files to a static folder and replaces placeholders
- clean - removes the static folder
- loop - runs the build recipe once a second

### Production/Staging deployments

Push your branch and netlify will take care of the rest :)

Note that the build agents on netlify use dash by default. To verify the build will continue to work (in particular the Makefile)
ensure dash is installed locally then run `./test.sh`.

This will just loop through some common shells and run `make clean build`.

### AWS

The contact functionality on the webpage is backed by some services running in AWS. These are
- API gateway - hosts the actual API (https://app.swaggerhub.com/apis/andrewflbarnes/andrewflbarnes/1.0.0
- Lambda - a serverless function which integrates with SES to deliver the email

(WIP) Some of these services are managed through terraform which can be found in the aws folder.

To generate the required resources
```bash
cd aws

# download swagger spec and package lambda files
make build

terraform apply -var-file aflb.tfvars
```

The final output (which can also be retrieved with `terraform output`) contains the DNS records and certificate ARN for the custom domain.
