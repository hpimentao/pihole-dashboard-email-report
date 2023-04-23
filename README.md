<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <h1>Pi-hole Dashboard Email Report</h1>
    <p>This project provides a script to generate an email report with Pi-hole dashboard statistics. The report includes data such as total queries, blocked queries, unique domains, and more.</p>
    <h2>Installation and Setup</h2>
    <ol>
        <li><strong>Clone the repository</strong>
            <p>Open a terminal on your Raspberry Pi and run the following command to clone the repository:</p>
            <pre><code>git clone https://github.com/hpimentao/pihole-dashboard-email-report.git</code></pre>
            <p>This will create a directory named <code>pihole-dashboard-email-report</code> containing the project files.</p>
        </li>
        <li><strong>Change to the project directory</strong>
            <pre><code>cd pihole-dashboard-email-report</code></pre>
        </li>
        <li><strong>Install dependencies</strong>
            <p>The script requires <code>jq</code> and <code>msmtp</code>. If you haven't already installed them, use the following commands to install:</p>
            <pre><code>sudo apt-get update
sudo apt-get install jq msmtp</code></pre>
        </li>
        <li><strong>Configure email settings</strong>
            <p>Edit the <code>.msmtprc</code> configuration file in your home directory (or create one if it doesn't exist) and configure the SMTP settings for your email provider. Replace the placeholders with your actual email credentials and server information:</p>
            <pre><code>sudo nano ~/.msmtprc</code></pre>
            <pre><code>defaults
auth           on
tls            on
tls_trust_file /etc/ssl/certs/ca-certificates.crt
logfile        ~/.msmtp.log

account        your-email-provider
host           your-smtp-server
port           your-smtp-port
from           your-email@example.com
user           your-email@example.com
password       your-email-password

account default : your-email-provider</code></pre>
            <p>Save the changes and exit the editor (Ctrl + X, Y, Enter).</p>
        </li>
        <li><strong>Edit the script</strong>
            <p>Open the <code>pihole_stats_email.sh</code> script in a text editor:</p>
            <pre><code>sudo nano pihole_stats_email.sh</code></pre>
            <p>Replace the placeholder <code>your-email@example.com</code> with the email address you want to send the report to. Save the changes and exit the editor.</p>
        </li>
        <li><strong>Make the script executable</strong>
            <pre><code>sudo chmod +x pihole_stats_email.sh</code></pre>
        </li>
        <li><strong>Test the script</strong>
            <p>Run the script to generate and send a test email:</p>
            <pre><code>./pihole_stats_email.sh</code></pre>
            <p>Check your email inbox to verify that you received the Pi-hole dashboard report.</p>
        </li>
        <li><strong>Schedule the script with cron</strong>
            <p>To schedule the script to run automatically, you can add a cron job. Open your crontab configuration file:</p>
            <pre><code>crontab -e</code></pre>
            <p>Add a new line at the end of the file with the following format:</p>
            <pre><code>0 * * * * /path/to/pihole-dashboard-email/pihole_stats_email.sh</code></pre>
            <p>This will schedule the script to run every hour. Adjust the cron schedule according to your preference. Save the changes and exit the editor.</p>
        </li>
    </ol>
    <h2>Customization</h2>
    <p>The email report template is located in the <code>pihole_dashboard_template.html</code> file. You can customize the appearance and layout of the report by editing this file.</p>
</body>
</html>

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

