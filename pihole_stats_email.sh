#!/bin/bash

# Retrieve Pi-hole stats
PIHOLE_IP="192.168.1.150"
API_TOKEN="API_TOKEN"
stats=$(curl -k -s "https://$PIHOLE_IP/admin/api.php?summaryRaw&auth=$API_TOKEN")
hostname=$(hostname)

# Extract desired statistics
domains_being_blocked=$(echo "$stats" | jq '.domains_being_blocked')
dns_queries_today=$(echo "$stats" | jq '.dns_queries_today')
ads_blocked_today=$(echo "$stats" | jq '.ads_blocked_today')
ads_percentage_today=$(echo "$stats" | jq '.ads_percentage_today')
unique_domains=$(echo "$stats" | jq '.unique_domains')
queries_forwarded=$(echo "$stats" | jq '.queries_forwarded')
queries_cached=$(echo "$stats" | jq '.queries_cached')
clients_ever_seen=$(echo "$stats" | jq '.clients_ever_seen')
unique_clients=$(echo "$stats" | jq '.unique_clients')
dns_queries_all_types=$(echo "$stats" | jq '.dns_queries_all_types')
reply_CNAME=$(echo "$stats" | jq '.reply_CNAME')
reply_IP=$(echo "$stats" | jq '.reply_IP')

# Compose the HTML email content
subject="Pi-hole Dashboard for $hostname"

# Use the HTML template and replace placeholders with actual values
html_template_file="pihole_dashboard_template.html"
html_message=$(<"$html_template_file")
html_message=${html_message//"{{ hostname }}"/$hostname}
html_message=${html_message//"{{ domains_being_blocked }}"/$domains_being_blocked}
html_message=${html_message//"{{ dns_queries_today }}"/$dns_queries_today}
html_message=${html_message//"{{ ads_blocked_today }}"/$ads_blocked_today}
html_message=${html_message//"{{ ads_percentage_today }}"/$ads_percentage_today}
html_message=${html_message//"{{ unique_domains }}"/$unique_domains}
html_message=${html_message//"{{ queries_forwarded }}"/$queries_forwarded}
html_message=${html_message//"{{ queries_cached }}"/$queries_cached}
html_message=${html_message//"{{ clients_ever_seen }}"/$clients_ever_seen}
html_message=${html_message//"{{ unique_clients }}"/$unique_clients}
html_message=${html_message//"{{ dns_queries_all_types }}"/$dns_queries_all_types}
html_message=${html_message//"{{ reply_CNAME }}"/$reply_CNAME}
html_message=${html_message//"{{ reply_IP }}"/$reply_IP}

# Save the HTML message to a temporary file
temp_file=$(mktemp)
echo "$html_message" > "$temp_file"

# Send the email with the HTML content type
{
  echo "Subject: $subject"
  echo "From: noreply-alerts@mupns.com"
  echo "To: email1@domain.com,email2@domain.com"
  echo "MIME-Version: 1.0"
  echo "Content-Type: text/html"
  echo
  cat "$temp_file"
} | msmtp -t

# Clean up the temporary file
rm "$temp_file"
