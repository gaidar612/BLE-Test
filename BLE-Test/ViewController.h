//
//  ViewController.h
//  BLE-Test
//
//  Created by Admin on 06.11.15.
//  Copyright © 2015 George. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController : UIViewController <CBCentralManagerDelegate> {
    CBCentralManager *centralManager;
}
@property (weak, nonatomic) IBOutlet UILabel *labelText;

- (NSString *) getPeripheralId:(CBPeripheral *)aPeripheral;

@end

