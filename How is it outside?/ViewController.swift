
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var captureCity: UITextField!
    
    @IBOutlet weak var labelWeather: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "wallpaper.jpg")!)
    }

    @IBAction func startWebServiceCall(sender: UIButton) {
        
            callWebService()
        
    }
    
    
    func callWebService(){
        let urlPath = "http://api.openweathermap.org/data/2.5/weather?q=\(captureCity.text)rosario&APPID=d636acbc54f8bbf3a1845b918f1fe3c0"
        let url = URL(string: urlPath)
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!,completionHandler:
            {data, response, error -> Void in
                
                if (error != nil){
                    print(error?.localizedDescription)
                    
                }
                
                var nsdata:NSData = NSData(data: data!)
                print(nsdata)
                self.getWeatherJson(nsdata: nsdata)
                })
        task.resume()
    }
    
    
    
        
    func getWeatherJson(nsdata:NSData){
        
        let jsonComplete : AnyObject! = JSONSerialization.JSONObjectWithData( nsdata, options: NSJONReadingOptions.MutableContainers, error: nil)
        print(jsonComplete)
        
        let arrayJsonWeather = jsonComplete["weather"]
        
        if let jsonArray = arrayJsonWeather as? NSArray{
            
            jsonArray.enumerateObjects({model, index, stop in
                let weather = model["description"] as String
                print(weather)
                self.description.labelWeather.text = weather
            });
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

