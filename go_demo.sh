# This is a short shell script that you can use to create a few
# resources using my own little/incomplete/fake LDP Server
# (download from https://github.com/hectorcorrea/ldpserver/releases)
# and see the differnces between RDF Sources, and Non-RDF Sources,
# as well as some of the neat things that Direct Containers do
# for you.
#
# Before you start:
#
#   1. Make sure the LDP_SERVER variable points to your root path.
#      By default this will be http://localhost:9001
#
#   2. Update the ROOT_ID to an ID that you have never used before.
#
#   3. Update file speakers.ttl to use the same ID that you use in ROOT_ID.
#
LDP_SERVER="http://localhost:9001"
ROOT_ID="hydraconnect2015"
ROOT_NODE="${LDP_SERVER}/${ROOT_ID}"


# Create the root node (TODO: support PUT)
curl -X POST --data "@root.ttl" --header "Slug: ${ROOT_ID}" --header "Content-Type: text/turtle" ${LDP_SERVER}


# Add an RDF Source with session1 information
curl -X POST --data "@session1.ttl" --header "Content-Type: text/turtle" --header "Slug: session1" ${ROOT_NODE}


# Declare a Direct Container for "speakers" (TODO: Remove PATCH calls)
curl -X POST --data "@speakers2.ttl" --header "Content-Type: text/turtle" --header "Slug: speakers" ${ROOT_NODE}
curl -X PATCH -d "<> <http://www.w3.org/ns/ldp#hasMemberRelation> <http://myfakeontology.org/hasSpeaker> ." ${ROOT_NODE}/speakers
curl -X PATCH -d "<> <http://www.w3.org/ns/ldp#membershipResource> <${ROOT_NODE}> ." ${ROOT_NODE}/speakers


# Add a new speaker
curl -X POST --data "@janedev.ttl" --header "Content-Type: text/turtle" --header "Slug: janedev" ${ROOT_NODE}/speakers


# Add a Non-RDF Source
curl -X POST --header "Link: http://www.w3.org/ns/ldp#NonRDFSource; rel=\"type\"" --data-binary "@thumbnail.jpg" --header "Slug: thumbnail.jpg" ${ROOT_NODE}


# Once you have run this script then you can browse to your
# ROOT_NODE and see the results. Assuming your ROOT_NODE points
# to localhost:9001/hdyraconnect2015 you should have the following
# URLs:
#
#     /localhost:9001/hydraconnect2015
#     /localhost:9001/hydraconnect2015/session1
#     /localhost:9001/hydraconnect2015/speakers
#     /localhost:9001/hydraconnect2015/speakers/janedev
#
# Notice that /localhost:9001/hydraconnect2015 has two triples with
# ldp:contains predicate pointing to session1 and speakers.
#
# Notice that it also has a triple with predicate hasSpeaker
# pointing to speakers/janedev


