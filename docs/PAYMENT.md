# Payment Workflow

JL-Agent is open source and free to use. Paid setup is a manual service workflow.

Paid plan examples:

- 7-Day Trial: USD 0
- 30-Day Express: USD 3.90
- Lifetime: USD 9.90 one-time

Lifetime means the paid deployment pack and stated support scope, not unlimited custom development.

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

## EXE Trial And Manual Activation

For the lightweight paid EXE flow:

1. The client runs `xjlagent.exe`.
2. JL-Agent shows the plan menu before entering the terminal UI.
3. If the client chooses `7-Day Trial`, JL-Agent writes a local 7-day license and enters the terminal UI.
4. If the client chooses `30-Day Express` or `Lifetime`, JL-Agent opens the local Dashboard payment page and shows the machine code.
5. The client pays with WeChat Pay and sends you the machine code.
6. You generate an activation code:

```bash
python xjlagent.py --make-activation express MACHINE_CODE
python xjlagent.py --make-activation lifetime MACHINE_CODE
```

7. The client activates:

```bat
xjlagent.exe --activate ACTIVATION_CODE
```

Useful support commands:

```bash
python xjlagent.py --machine-code
python xjlagent.py --license-status
```

This is a lightweight offline activation flow for low-price distribution. It is not strong DRM. Because JL-Agent is open source, determined users can modify the code. For serious automatic billing and enforcement, use a real merchant payment API and a server-side license service.

## What Not To Publish

Do not commit personal payment QR codes, merchant private keys, API credentials, phone numbers, ID documents, bank details, or invoices with private information to this public repository.

If a public payment page is needed later, use a merchant payment link or a dedicated landing page instead of committing raw personal QR codes into the repository.

## Dashboard QR Code

To show a WeChat payment QR code inside the local dashboard:

1. Create a local folder named `payment` next to `xjlagent.py`.
2. Save your WeChat payment QR image as `payment/wechat_qr.png`.
3. Start the dashboard with `python xjlagent.py --dashboard`.
4. Click `Plans`, then choose `30-Day Express` or `Lifetime`.

You can also point to another local image path:

```bash
export JL_AGENT_WECHAT_QR="/path/to/wechat_qr.png"
python xjlagent.py --dashboard
```

On Windows:

```bat
set JL_AGENT_WECHAT_QR=C:\path\to\wechat_qr.png
python xjlagent.py --dashboard
```

For a private customer EXE, put `payment/wechat_qr.png` in the project folder before running `build_xjlagent_exe.bat`. The spec automatically embeds that local file into `xjlagent.exe`, so the customer package does not need to expose a separate QR image file. The QR is still visible when the app opens the payment page, and users can always screenshot it; this is packaging hygiene, not copy protection.

## Notes

Payment only covers setup, deployment support, documentation, and customization work. It does not sell the open-source code itself.

Financial and stock-market workflows are research support only. JL-Agent does not provide investment advice, does not place trades, and does not guarantee investment results.
