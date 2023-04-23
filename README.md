<h2>Pi-hole Dashboard-like Email Report</h2>
<p>This project provides a script to generate a Pi-hole dashboard-like email report. The report will display key statistics from your Pi-hole, such as the number of blocked ads, DNS queries, and other relevant data.</p>
<h3>Prerequisites</h3>
<ul>
  <li>Raspberry Pi 4 running Pi-hole</li>
  <li>msmtp for sending emails</li>
  <li>jq for JSON parsing</li>
</ul>
<h3>Installation and Setup</h3>
<ol>
  <li>Install msmtp and jq if not already installed:<br><code>sudo apt-get install msmtp jq</code></li>
  <li>Configure msmtp to send emails. See <a href="https://wiki.archlinux.org/title/msmtp">msmtp documentation</a> for more details.</li>
  <li>Create a new directory for the project:<br><code>mkdir pihole_dashboard_email</code></li>
  <li>Change into the new directory:<br><code>cd pihole_dashboard_email</code></li>
  <li>Create a new file named <code>pihole_stats_email.sh</code> and paste the provided script into it. Update the email address in the script to your desired recipient.</li>
  <li>Make the script executable:<br><code>chmod +x pihole_stats_email.sh</code></li>
  <li>Create a new file named <code>pihole_dashboard_template.html</code> and paste the provided HTML template into it.</li>
  <li>Test the script by running it:<br><code>./pihole_stats_email.sh</code></li>
  <li>Schedule the script to run periodically using <code>cron</code> or another scheduler, if desired.</li>
</ol>
<h3>Usage</h3>
<p>Run the <code>pihole_stats_email.sh</code> script to generate the Pi-hole dashboard-like email report. The report will be sent to the email address specified in the script.</p>
<h3>HTML template</h3>
<body>
    <h1>Pi-hole Dashboard for {{ hostname }}</h1>
    <table>
        <tr>
            <th>Statistic</th>
            <th>Value</th>
        </tr>
        <tr>
            <td>Domains Being Blocked</td>
            <td>{{ domains_being_blocked }}</td>
        </tr>
        <tr>
            <td>DNS Queries Today</td>
            <td>{{ dns_queries_today }}</td>
        </tr>
        <tr>
            <td>Ads Blocked Today</td>
            <td>{{ ads_blocked_today }}</td>
        </tr>
        <tr>
            <td>Ads Percentage Today</td>
            <td>{{ ads_percentage_today }}%</td>
        </tr>
        <tr>
            <td>Unique Domains</td>
            <td>{{ unique_domains }}</td>
        </tr>
        <tr>
            <td>Queries Forwarded</td>
            <td>{{ queries_forwarded }}</td>
        </tr>
        <tr>
            <td>Queries Cached</td>
            <td>{{ queries_cached }}</td>
        </tr>
        <tr>
            <td>Clients Ever Seen</td>
            <td>{{ clients_ever_seen }}</td>
        </tr>
        <tr>
            <td>Unique Clients</td>
            <td>{{ unique_clients }}</td>
        </tr>
        <tr>
            <td>DNS Queries (All Types)</td>
            <td>{{ dns_queries_all_types }}</td>
        </tr>
        <tr>
            <td>Reply CNAME</td>
            <td>{{ reply_CNAME }}</td>
        </tr>
        <tr>
            <td>Reply IP</td>
            <td>{{ reply_IP }}</td>
        </tr>
    </table>
</body>

