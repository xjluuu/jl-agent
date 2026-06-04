# Payment Workflow

JL-Agent is open source and free to use. Paid setup is a manual service workflow.

## Supported Payment Methods

For China-based clients:

- Alipay
- WeChat Pay

For non-China clients, use a separate method such as PayPal, Wise, Stripe, Paddle, or another agreed channel.

## Recommended Flow

1. The client opens a paid setup request:
   https://github.com/xjluuu/jl-agent/issues/new?template=paid_setup.yml
2. Confirm the scope, delivery items, timeline, and final price.
3. Send the Alipay or WeChat payment QR code privately after the scope is confirmed.
4. Confirm payment received before starting delivery work.
5. Deliver setup notes, configuration guidance, or handover files.

## What Not To Publish

Do not commit personal payment QR codes, merchant private keys, API credentials, phone numbers, ID documents, bank details, or invoices with private information to this public repository.

If a public payment page is needed later, use a merchant payment link or a dedicated landing page instead of committing raw personal QR codes into the repository.

## Notes

Payment only covers setup, deployment support, documentation, and customization work. It does not sell the open-source code itself.

Financial and stock-market workflows are research support only. JL-Agent does not provide investment advice, does not place trades, and does not guarantee investment results.
