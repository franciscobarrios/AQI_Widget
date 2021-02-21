using Toybox.WatchUi;

class AQI_ErrorView extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    function onLayout(dc) {
        setLayout(Rez.Layouts.ErrorLayout(dc));
        var view = View.findDrawableById("Message");
        var errorMessage = WatchUi.loadResource(Rez.Strings.error);
        view.setText(errorMessage);
    }

}