# Quickstart

JL-Agent can run directly with Python on macOS, Windows, and Linux. On Windows, it can also be packaged as an `.exe` for users who do not have Python.

## 1. Install dependencies

```bash
python -m pip install -r requirements.txt
```

## 2. Initialize config

```bash
python xjlagent.py --init-config
python xjlagent.py --config-path
```

Edit the generated config file and set:

- `api.url`
- `api.key`
- `api.model`

If your internal model gateway does not require authentication, `api.key` can stay empty.

## 3. Run self-check

```bash
python xjlagent.py --self-check
```

Warnings are acceptable when they describe optional capabilities, such as missing PDF support.

The self-check output shows the actual runtime config and data paths for the current machine.

## 4. Start interactive mode

```bash
python xjlagent.py
```

## 5. Start dashboard

```bash
python xjlagent.py --dashboard
```

Open:

```text
http://127.0.0.1:18888
```

## Optional payment QR

If you distribute a paid deployment build, save your WeChat payment QR image as:

```text
payment/wechat_qr.png
```

Then start the dashboard and click `Plans`. The modal shows:

- 7-Day Trial: free
- 30-Day Express: USD 3.90
- Lifetime: USD 9.90
- Custom Enterprise: quote by scope

Do not commit the `payment/` folder to a public repository.
