# This is a short shell script that you can use to create a few
# resources in Fedora and see the differnces between RDF Sources,
# and Non-RDF Sources, as well as some of the neat things that
# Direct Containers do for you.
#
# Before you start:
#
#   1. Make sure the LDP_SERVER points to your Fedora root.
#      Fedora standalone runs on port 8080, with Jetty it runs on port 8983.
#      Update the LDP_SERVER accordingly.
#
#   2. Update the ROOT_NODE to an ID that you have never used before.
#
#   3. Update file speakers.ttl to use the same ID that you use in ROOT_NODE.
#
LDP_SERVER="http://fedoraAdmin:fedoraAdmin@localhost:8983/fedora/rest"
ROOT_NODE="${LDP_SERVER}/demo100"


# Create the root node (/demoNNN)
curl -X PUT ${ROOT_NODE}


# Add an RDF Source with the conference information.
curl -X POST --data "@conference.ttl" --header "Content-Type: text/turtle" --header "Slug: hydraconnect2015" ${ROOT_NODE}


# Add an RDF Source with session1 information
curl -X POST --data "@session1.ttl" --header "Content-Type: text/turtle" --header "Slug: session1" ${ROOT_NODE}/hydraconnect2015


# Declare a Direct Container for "speakers"
curl -X POST --data "@speakers.ttl" --header "Content-Type: text/turtle" --header "Slug: speakers" ${ROOT_NODE}


# Add a new speaker
curl -X POST --data "@janedev.ttl" --header "Content-Type: text/turtle" --header "Slug: janedev" ${ROOT_NODE}/speakers


# Add a Non-RDF Source
curl -X POST --data-binary "@thumbnail.jpg" --header "Slug: thumbnail.jpg" ${ROOT_NODE}


# Once you have run this script then you can browse to your
# ROOT_NODE and see the results. Assuming your ROOT_NODE points
# to /fedora/rest/hdyraconnect2015 you should have the following
# URLs:
#
#     /fedora/rest/demo01/hydraconnect2015
#     /fedora/rest/demo01/hydraconnect2015/session1
#     /fedora/rest/demo01/speakers
#     /fedora/rest/demo01/speakers/janedev
#
# Notice that /fedora/rest/demo01/hydraconnect2015 has a triples with
# ldp:contains predicate pointing to session1.
#
# Notice that it also has a triple with predicate hasSpeaker
# pointing to /fedora/rest/speakers/janedev


