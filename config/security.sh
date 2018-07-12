#!/bin/sh

HOST=elasticsearch
PORT=9200
TIMEOUT=30

BASEURL="http://$HOST:$PORT"
alias jpost="curl -s -uelastic:elastic -XPOST -H 'Content-Type: application/json'"
alias jput="curl -s -uelastic:elastic -XPUT -H 'Content-Type: application/json'"

# Wait for ElasticSearch to be ready for connections
for i in `seq $TIMEOUT` ; do
  sleep 5
  curl -sf "$HOST:$PORT" > /dev/null
  if [ $? -eq 0 ] ; then
    echo "Activating XPACK trial"
    # https://www.elastic.co/guide/en/elasticsearch/reference/6.3/start-trial.html
    jpost -d '' "$BASEURL/_xpack/license/start_trial?acknowledge=true"
    echo ""

    echo "Setting kibana password"
    jput -d "{\"password\":\"$KIBANA_PASSWORD\"}" "$BASEURL/_xpack/security/user/kibana/_password"
    echo ""

    echo "Creating superpoder logstash user"
    jpost -d '{"cluster":["manage_index_templates","monitor"],"indices":[{"names":"*","privileges":["read","write","delete","create_index","view_index_metadata"]}]}' "$BASEURL/_xpack/security/role/logstash_poder"
    echo ""
    jpost -d "{\"password\":\"$LOGSTASH_PASSWORD\",\"roles\":[\"logstash_poder\",\"logstash_admin\"],\"full_name\":\"Logstash Poder\"}" "$BASEURL/_xpack/security/user/logstash_poder"
    echo ""
    exit 0
  fi
  echo "Waiting for ElasticSearch"
done
echo "Unable to connect with ElasticSearch" >&2
exit 1
