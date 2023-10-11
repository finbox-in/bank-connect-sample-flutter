package `in`.finbox.flutter_bc_sample_app
import `in`.finbox.bankconnect.finbox_bc_plugin.FinBoxBcPlugin
import io.flutter.app.FlutterApplication



class MainApp: FlutterApplication() {
    override fun onCreate() {
        super.onCreate()
        FinBoxBcPlugin.initLibrary(this)
    }
}