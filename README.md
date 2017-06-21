# Packer and Terraform Pattern Example

This repository houses a simple application that demonstrates an end-to-end
infrastructure as code pattern using Packer and Terraform.

[comment]: <> ( This repo will serve as a technical example for my next whitepage on  )
[comment]: <> ( Server Design Pattern: A                       )
[comment]: <> ( https://www.linkedin.com/in/ehimeprefecture/treasury/position )

## The Components

 * A small ruby gem (`ehime_hello`). This is built using rubygems tasks
   using `rake`.
 * A Chef recipe designed for deploying the application (`packer_payload`).
   This is a single-purpose cookbook that is not intended to be shared in
   Supermarket, etc. It's only intended for use with Packer. With that said,
   having a cookbook allows you to port this functionality to a general-use
   cookbook if necessary - this can then be included from a fresh
   `packer_payload` cookbook.
 * A packer template located at `packer/ami.json`
 * Terraform infrastructure in the `terraform` directory, comprised of a single
   template for now, `main.tf`.

You manage all of this with `rake`.
