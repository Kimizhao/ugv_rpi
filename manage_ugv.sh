#!/bin/bash
APP_CMD="XDG_RUNTIME_DIR=/run/user/1000 ~/ugv_rpi/ugv-env/bin/python ~/ugv_rpi/app.py"
APP_NAME="app.py"

case "$1" in
    start)
        PID=$(pgrep -f "$APP_NAME")
        if [ -n "$PID" ]; then
            echo "程序已在运行 (PID: $PID)"
        else
            bash -c "$APP_CMD" >> ~/ugv.log 2>&1 &
            echo "程序已启动 (PID: $!)"
        fi
        ;;
    stop)
        PID=$(pgrep -f "$APP_NAME")
        if [ -n "$PID" ]; then
            kill $PID
            echo "程序已停止 (PID: $PID)"
        else
            echo "程序未运行"
        fi
        ;;
    restart)
        $0 stop
        sleep 2
        $0 start
        ;;
    status)
        PID=$(pgrep -f "$APP_NAME")
        if [ -n "$PID" ]; then
            echo "程序运行中 (PID: $PID)"
        else
            echo "程序未运行"
        fi
        ;;
    *)
        echo "用法: $0 {start|stop|restart|status}"
        exit 1
        ;;
esac

