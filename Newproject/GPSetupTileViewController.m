//
//  GPSetupTileViewController.m
//  Newproject
//
//  Created by GMSIndia 2 on 23/05/14.
//  Copyright (c) 2014 GMSIndia1. All rights reserved.
//

#import "GPSetupTileViewController.h"

@interface GPSetupTileViewController ()

@end

@implementation GPSetupTileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _result=@"";
    _ModuleID=0;
     self.view.backgroundColor=[UIColor colorWithRed:234.0/255.0f green:226/255.0f blue:226/255.0f alpha:1.0f];
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]
                                         initWithTarget:self
                                         action:@selector(crewpage)];
    doubleTap.numberOfTapsRequired=1;
    doubleTap.delegate=(id)self;
    [self.manview addGestureRecognizer:doubleTap];
    
    UITapGestureRecognizer *doubleTap1 = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(equipPage)];
    doubleTap1.numberOfTapsRequired=1;
    doubleTap1.delegate=(id)self;
    [self.equipview addGestureRecognizer:doubleTap1];
    UITapGestureRecognizer *doubleTap2 = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(materialsPage)];
    doubleTap2.numberOfTapsRequired=1;
    doubleTap2.delegate=(id)self;
    [self.materview addGestureRecognizer:doubleTap2];
   
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _manview.userInteractionEnabled=YES;
    _gpmanactivity.hidden=YES;
    _equipview.userInteractionEnabled=YES;
    _gpequactivity.hidden=YES;
    _materview.userInteractionEnabled=YES;
    _gpmateractivity.hidden=YES;
    [_gpmateractivity stopAnimating];
    [_gpequactivity stopAnimating];
    [_gpmanactivity stopAnimating];


    
    

}
-(IBAction)closethegroup:(id)sender

{
    _result=@"";
    _ModuleID=0;
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void)crewpage
{     _gpmanactivity.hidden=NO;
    [_gpmanactivity startAnimating];
    _ModuleID=31;
    [self UserLogmaininsert];

    [self UserRightsforparticularmoduleselect];
    _manview.userInteractionEnabled=NO;

  
}

-(void)equipPage{
   
    _gpequactivity.hidden=NO;
      [_gpequactivity startAnimating];

    _ModuleID=32;
    [self UserLogmaininsert];
    [self UserRightsforparticularmoduleselect];
     _equipview.userInteractionEnabled=NO;

  
}
-(void)materialsPage
{
  
    _gpmateractivity.hidden=NO;
    [_gpmateractivity startAnimating];

    _ModuleID=33;
    [self UserLogmaininsert];
    [self UserRightsforparticularmoduleselect];
      _materview.userInteractionEnabled=NO;

    }
#pragma mark-Webservice
-(void)UserRightsforparticularmoduleselect{
    recordResults = FALSE;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    userid = [defaults objectForKey:@"Userid"];
    
    
    NSString *soapMessage;
    
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<UserRightsforparticularmoduleselect xmlns=\"http://testUSA.kontract360.com/\">\n"
                   "<UserId>%d</UserId>\n"
                   "<ModuleId>%d</ModuleId>\n"
                   "</UserRightsforparticularmoduleselect>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",[userid integerValue],_ModuleID];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    // NSURL *url = [NSURL URLWithString:@"http://test.kontract360.com/service.asmx"];
    NSURL *url = [NSURL URLWithString:@"http://test.kontract360.com/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"http://testUSA.kontract360.com/UserRightsforparticularmoduleselect" forHTTPHeaderField:@"Soapaction"];
    
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if( theConnection )
    {
        _webData = [NSMutableData data];
    }
    else
    {
        ////NSLog(@"theConnection is NULL");
    }
    
}
-(void)UserLogmaininsert{
    
    recordResults = FALSE;
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *zone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:zone];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // NSLog(@"Date %@",[formatter stringFromDate:date]);
    NSString*curntdate=[formatter stringFromDate:date];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString*useridname = [defaults objectForKey:@"Userid"];
    NSString*extnalip=[defaults objectForKey:@"Externalip"];
    NSString*intrnalip=[defaults objectForKey:@"Internalip"];
    NSString*Udid=[defaults objectForKey:@"UDID"];
    
    
    NSString *soapMessage;
    
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<UserLogmaininsert xmlns=\"http://testUSA.kontract360.com/\">\n"
                   "<dateandtime>%@</dateandtime>\n"
                   "<userid>%d</userid>\n"
                   "<moduleid>%d</moduleid>\n"
                   "<Action>%@</Action>\n"
                   "<platform>%@</platform>\n"
                   "<externalip>%@</externalip>\n"
                   "<internalip>%@</internalip>\n"
                   "<devicenumber>%@</devicenumber>\n"
                   "<documentId>%d</documentId>\n"
                   "</UserLogmaininsert>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",curntdate,[useridname integerValue],_ModuleID,@"View",@"iOS",extnalip,intrnalip,Udid,0];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    // NSURL *url = [NSURL URLWithString:@"http://test.kontract360.com/service.asmx"];
    NSURL *url = [NSURL URLWithString:@"http://test.kontract360.com/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"http://testUSA.kontract360.com/UserLogmaininsert" forHTTPHeaderField:@"Soapaction"];
    
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if( theConnection )
    {
        _webData = [NSMutableData data];
    }
    else
    {
        ////NSLog(@"theConnection is NULL");
    }
    
}


#pragma mark - Connection
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	[_webData setLength: 0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
   	[_webData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView *  Alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please Check Your Connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [Alert show];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"DONE. Received Bytes: %d", [_webData length]);
	NSString *theXML = [[NSString alloc] initWithBytes: [_webData mutableBytes] length:[_webData length] encoding:NSUTF8StringEncoding];
	NSLog(@"xml===== %@",theXML);
    
    
	
	if( _xmlParser )
	{
		
	}
	
	_xmlParser = [[NSXMLParser alloc] initWithData: _webData];
	[_xmlParser setDelegate:(id)self];
	[_xmlParser setShouldResolveExternalEntities: YES];
    //NSDictionary *dictionary=[_xmlParser dictionaryWithValuesForKeys:[[NSArray alloc]initWithObjects:@"JobNumber", nil]];
    
    //  NSLog(@"dictioanry is %@",dictionary);
    
    
	[_xmlParser parse];
    if (checkws==2) {
        
    
    if ([_result isEqualToString:@"Not yet set"]) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Your rights are not yet set" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        _manview.userInteractionEnabled=YES;
        _gpmanactivity.hidden=YES;
        [_gpmanactivity stopAnimating];
        
        _equipview.userInteractionEnabled=YES;
        _gpequactivity.hidden=YES;
           [_gpequactivity stopAnimating];
        
        _materview.userInteractionEnabled=YES;
        _gpmateractivity.hidden=YES;
           [_gpmateractivity stopAnimating];
       
        
    }
    
    
    else
    {
        
        if (_ModuleID==31) {
            
            
            Rightscheck*rightsmodel=(Rightscheck *)[_userrightsarray objectAtIndex:0];
            if (rightsmodel.ViewModule==1) {
                
                _manview.userInteractionEnabled=YES;
                _gpmanactivity.hidden=YES;
                [_gpmanactivity stopAnimating];
                
                _equipview.userInteractionEnabled=YES;
                _gpequactivity.hidden=YES;
                [_gpequactivity stopAnimating];
                
                _materview.userInteractionEnabled=YES;
                _gpmateractivity.hidden=YES;
                [_gpmateractivity stopAnimating];
                //if (!self.crewctrl) {
                _crewctrl=[[CrewsetupViewController alloc]initWithNibName:@"CrewsetupViewController" bundle:nil];
                // }
                //_crewctrl.modalPresentationStyle = UIModalPresentationPageSheet;
                _crewctrl.userrightsarray=_userrightsarray;
                [self presentViewController:_crewctrl
                                   animated:YES completion:NULL];

                
            }
            else
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"You don’t have right to view this form" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                _manview.userInteractionEnabled=YES;
                _gpmanactivity.hidden=YES;
                [_gpmanactivity stopAnimating];
                
                _equipview.userInteractionEnabled=YES;
                _gpequactivity.hidden=YES;
                [_gpequactivity stopAnimating];
                
                _materview.userInteractionEnabled=YES;
                _gpmateractivity.hidden=YES;
                [_gpmateractivity stopAnimating];

                //You don’t have right to view this form
            }
           
            
        }
        if (_ModuleID==32) {
            Rightscheck*rightsmodel=(Rightscheck *)[_userrightsarray objectAtIndex:0];
            if (rightsmodel.ViewModule==1) {
                _manview.userInteractionEnabled=YES;
                _gpmanactivity.hidden=YES;
                [_gpmanactivity stopAnimating];
                
                _equipview.userInteractionEnabled=YES;
                _gpequactivity.hidden=YES;
                [_gpequactivity stopAnimating];
                
                _materview.userInteractionEnabled=YES;
                _gpmateractivity.hidden=YES;
                [_gpmateractivity stopAnimating];

                
                //  if (!self.equipVCtrl) {
                _equipVCtrl=[[GroupEqupViewController alloc]initWithNibName:@"GroupEqupViewController" bundle:nil];
                // }
                //_equipVCtrl.modalPresentationStyle = UIModalPresentationFullScreen;
                _equipVCtrl.userrightsarray=_userrightsarray;
                [self presentViewController:_equipVCtrl
                                   animated:YES completion:NULL];
                
            }
            else
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"You don’t have right to view this form" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                _manview.userInteractionEnabled=YES;
                _gpmanactivity.hidden=YES;
                [_gpmanactivity stopAnimating];
                
                _equipview.userInteractionEnabled=YES;
                _gpequactivity.hidden=YES;
                [_gpequactivity stopAnimating];
                
                _materview.userInteractionEnabled=YES;
                _gpmateractivity.hidden=YES;
                [_gpmateractivity stopAnimating];

            }
          

        }
        if (_ModuleID==33)
        {
            Rightscheck*rightsmodel=(Rightscheck *)[_userrightsarray objectAtIndex:0];
            if (rightsmodel.ViewModule==1) {
                _manview.userInteractionEnabled=YES;
                _gpmanactivity.hidden=YES;
                [_gpmanactivity stopAnimating];
                
                _equipview.userInteractionEnabled=YES;
                _gpequactivity.hidden=YES;
                [_gpequactivity stopAnimating];
                
                _materview.userInteractionEnabled=YES;
                _gpmateractivity.hidden=YES;
                [_gpmateractivity stopAnimating];

                //if (!self.materialVCtrl) {
                _materialVCtrl=[[GpMaterViewController alloc]initWithNibName:@"GpMaterViewController" bundle:nil];
                //}
                //_materialVCtrl.modalPresentationStyle = UIModalPresentationPageSheet;
                _materialVCtrl.userrightsarray=_userrightsarray;
                [self presentViewController:_materialVCtrl
                                   animated:YES completion:NULL];
   }
            else
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"You don’t have right to view this form" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                _manview.userInteractionEnabled=YES;
                _gpmanactivity.hidden=YES;
                [_gpmanactivity stopAnimating];
                
                _equipview.userInteractionEnabled=YES;
                _gpequactivity.hidden=YES;
                [_gpequactivity stopAnimating];
                
                _materview.userInteractionEnabled=YES;
                _gpmateractivity.hidden=YES;
                [_gpmateractivity stopAnimating];

            }
           
            
        }
        
    }
        checkws=0;
    }
    
}

#pragma mark-xml parser
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict{
    if([elementName isEqualToString:@"UserRightsforparticularmoduleselectResponse"])
    {
        
        checkws=2;
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"result"])
    {
        
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"EntryId"])
    {
        _userrightsarray=[[NSMutableArray alloc]init];
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"UserId"])
    {
        
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"ModuleId"])
    {
        
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"ViewModule"])
    {
        
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"EditModule"])
    {
        
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"DeleteModule"])
    {
        
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"PrintModule"])
    {
        
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    }
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
    
    
	if( recordResults )
        
	{
        
        
		[_soapResults appendString: string];
    }
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"message"]){
        
        recordResults = FALSE;
        [self.navigationController popToRootViewControllerAnimated:YES];
        _soapResults=nil;
    }
    if([elementName isEqualToString:@"result"])
    {
        
        
        recordResults = FALSE;
        
        _result=@"Not yet set";
        //        if ([_soapResults isEqualToString:@"0"]) {
        //            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"You don’t have right to view this form" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //            [alert show];
        //        }
        
        _soapResults=nil;
    }
    
    if([elementName isEqualToString:@"EntryId"])
    {
        
        
        recordResults = FALSE;
        _rights=[[Rightscheck alloc]init];
        _rights.entryid=[_soapResults integerValue];
        
        _soapResults=nil;
    }
    if([elementName isEqualToString:@"UserId"])
    {
        
        
        recordResults = FALSE;
        
        _rights.userid=[_soapResults integerValue];
        
        _soapResults=nil;
    }
    if([elementName isEqualToString:@"ModuleId"])
    {
        
        
        recordResults = FALSE;
        
        _rights.moduleid=[_soapResults integerValue];
        
        _soapResults=nil;
        
    }
    if([elementName isEqualToString:@"ViewModule"])
    {
        
        recordResults = FALSE;
        
        if ([_soapResults isEqualToString:@"true"]) {
            _rights.ViewModule=1;
            
            
        }
        else{
            _rights.ViewModule=0;
            
        }
        
        
        
        _soapResults=nil;
        
        
    }
    if([elementName isEqualToString:@"EditModule"])
    {
        recordResults = FALSE;
        if ([_soapResults isEqualToString:@"true"]) {
            _rights.EditModule=1;
            
            
        }
        else{
            _rights.EditModule=0;
            
        }
        _soapResults=nil;
        
        
    }
    if([elementName isEqualToString:@"DeleteModule"])
    {
        recordResults = FALSE;
        if ([_soapResults isEqualToString:@"true"]) {
            _rights.DeleteModule=1;
            
            
        }
        else{
            _rights.DeleteModule=0;
            
        }
        _soapResults=nil;
        
    }
    if([elementName isEqualToString:@"PrintModule"])
    {
        recordResults = FALSE;
        if ([_soapResults isEqualToString:@"true"]) {
            _rights.PrintModule=1;
            
            
        }
        else{
            _rights.PrintModule=0;
            
        }
        
        
        
        [_userrightsarray addObject:_rights];
        _soapResults=nil;
        
    }
    
}


@end
