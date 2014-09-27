#!/bin/sh

# Define variables
mkjl_root=$(dirname $0)
jails_root="/usr/jails/"
hostname=$1
template=$2
template_recipe="${mkjl_root}/templates/${template}.sh"
template_path="${jails_root}/${template}"

# Functions
. "${mkjl_root}/src/functions.sh"
. "${mkjl_root}/src/base_template.sh"

# Create /usr/jails if needed
if [ ! -d "/usr/jails" ]; then
    mkdir /usr/jails || error_exit "Cannot create /usr/jails"
fi

# If the jail already exists, abort the provisioning with an error.
if [ -d "/usr/jails/$hostname" ]; then
    error_exit "$hostname already exists. Aborting..."
fi

# The requested template must exist.
if [ ! -f "${template_recipe}" ]; then
    error_exit "ERROR: Template '${template}' not found at ${template_recipe}." 2
fi

# Sourcing the template
. "${template_recipe}"

# Probing the environment
mkjl_prepare_env

# If we don't already have the template contents, then download it.
if [ ! -d "${template_path}" ]; then
    mkjl_prepare_fs
fi

# Provision
mkjl_provision

# Then configure the jail
mkjl_configure

echo "$hostname is ready"
