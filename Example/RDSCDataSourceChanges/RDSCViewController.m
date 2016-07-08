//
//  RDSCViewController.m
//  RDSCDataSourceChanges
//
//  Created by Richard Reitzfeld on 07/06/2016.
//  Copyright (c) 2016 Richard Reitzfeld. All rights reserved.
//

#import "RDSCViewController.h"

#import <RTSMTableSectionManager/RTSMTableSectionManager.h>
#import <RTSMTableSectionManager/UITableView+RTSMEmptySpace.h>

#import "NSString+RUMacros.h"
#import "RUConditionalReturn.h"





typedef NS_ENUM(NSInteger, RDSCViewController_tableView_section) {
	RDSCViewController_tableView_section_top_possiblyToggled,
	RDSCViewController_tableView_section_top_toggle,
	RDSCViewController_tableView_section_red,
	RDSCViewController_tableView_section_green,
	RDSCViewController_tableView_section_blue,
	RDSCViewController_tableView_section_toggle,
	RDSCViewController_tableView_section_possiblyToggled,
	RDSCViewController_tableView_section_alwaysBottom,
	
	RDSCViewController_tableView_section__first		= RDSCViewController_tableView_section_top_possiblyToggled,
	RDSCViewController_tableView_section__last		= RDSCViewController_tableView_section_alwaysBottom,
};





@interface RDSCViewController () <UITableViewDelegate,UITableViewDataSource,RTSMTableSectionManager_SectionDelegate>

#pragma mark - tableSectionManager
@property (nonatomic, readonly, nullable) RTSMTableSectionManager* tableSectionManager;
-(void)tableSectionManager_validate;

#pragma mark - top_toggled
@property (nonatomic, assign) BOOL top_toggled;

#pragma mark - toggled
@property (nonatomic, assign) BOOL toggled;

#pragma mark - tableView
@property (nonatomic, readonly, nullable) UITableView* tableView;
-(CGRect)tableViewFrame;

#pragma mark - Cell Background Color
-(nullable UIColor*)cellBackroundColorForTableViewSection:(RDSCViewController_tableView_section)tableViewSection;

#pragma mark - Cell Background Color
-(nullable NSString*)cellTextForTableViewSection:(RDSCViewController_tableView_section)tableViewSection;

@end

@implementation RDSCViewController
- (void)viewDidLoad
{
	[super viewDidLoad];
	
	[self.view setBackgroundColor:[UIColor whiteColor]];
	
	_tableSectionManager = [[RTSMTableSectionManager alloc]initWithFirstSection:RDSCViewController_tableView_section__first
																	lastSection:RDSCViewController_tableView_section__last];
	[self.tableSectionManager setSectionDelegate:self];
	
	[self tableSectionManager_validate];
	
	_tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
	[self.tableView setBackgroundColor:[UIColor clearColor]];
	[self.tableView setDelegate:self];
	[self.tableView setDataSource:self];
	[self.view addSubview:self.tableView];
}

-(void)viewWillLayoutSubviews
{
	[super viewWillLayoutSubviews];
	
	[self.tableView setFrame:self.tableViewFrame];
}

#pragma mark - Frames
-(CGRect)tableViewFrame
{
	return self.view.bounds;
}

#pragma mark - RTSMTableSectionManager_SectionDelegate
-(BOOL)tableSectionManager:(RTSMTableSectionManager *)tableSectionManager sectionIsAvailable:(NSInteger)section
{
	switch ((RDSCViewController_tableView_section)section)
	{
		case RDSCViewController_tableView_section_top_possiblyToggled:
			return (self.top_toggled == TRUE);
			break;
			
		case RDSCViewController_tableView_section_top_toggle:
		case RDSCViewController_tableView_section_red:
		case RDSCViewController_tableView_section_green:
		case RDSCViewController_tableView_section_blue:
		case RDSCViewController_tableView_section_toggle:
		case RDSCViewController_tableView_section_alwaysBottom:
			return YES;
			break;
			
		case RDSCViewController_tableView_section_possiblyToggled:
			return (self.toggled == TRUE);
			break;
	}
	
	NSAssert(false, @"unhandled");
	return NO;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return self.tableSectionManager.numberOfSectionsAvailable;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	kRUDefineNSStringConstant(kRDSCViewController_tableView_deque);
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kRDSCViewController_tableView_deque];
	
	if (cell == nil)
	{
		cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kRDSCViewController_tableView_deque];
	}
	
	RDSCViewController_tableView_section tableView_section = [self.tableSectionManager sectionForIndexPathSection:indexPath.section];
	
	[cell.contentView setBackgroundColor:[self cellBackroundColorForTableViewSection:tableView_section]];
	[cell.textLabel setTextColor:[UIColor blackColor]];
	[cell.textLabel setText:[self cellTextForTableViewSection:tableView_section]];
	
	return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 40.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	RDSCViewController_tableView_section tableView_section = [self.tableSectionManager sectionForIndexPathSection:indexPath.section];
	
	switch (tableView_section)
	{
		case RDSCViewController_tableView_section_top_possiblyToggled:
		case RDSCViewController_tableView_section_red:
		case RDSCViewController_tableView_section_green:
		case RDSCViewController_tableView_section_blue:
		case RDSCViewController_tableView_section_possiblyToggled:
		case RDSCViewController_tableView_section_alwaysBottom:
			break;
			
		case RDSCViewController_tableView_section_top_toggle:
			[self setTop_toggled:(self.top_toggled == false)];
			break;
			
		case RDSCViewController_tableView_section_toggle:
			[self setToggled:!self.toggled];
			break;
	}
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	RDSCViewController_tableView_section tableView_section = [self.tableSectionManager sectionForIndexPathSection:section];
	switch (tableView_section)
	{
		case RDSCViewController_tableView_section_top_possiblyToggled:
		case RDSCViewController_tableView_section_top_toggle:
		case RDSCViewController_tableView_section_red:
		case RDSCViewController_tableView_section_green:
		case RDSCViewController_tableView_section_blue:
		case RDSCViewController_tableView_section_toggle:
		case RDSCViewController_tableView_section_possiblyToggled:
			return 0.0f;
			break;
			
		case RDSCViewController_tableView_section_alwaysBottom:
		{
			CGFloat emptySpace = [self.tableView rtsm_emptySpaceFromSection:RDSCViewController_tableView_section__first
																  toSection:RDSCViewController_tableView_section_alwaysBottom
														tableSectionManager:self.tableSectionManager
																 tableFrame:self.tableViewFrame];
			
			CGFloat rowHeight = [self tableView:self.tableView
						heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
			
			return emptySpace - rowHeight;
		}
			break;
	}
	
	NSAssert(false, @"unhandled");
	return 0.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView* view = [UIView new];
	[view setBackgroundColor:[UIColor clearColor]];
	[view setUserInteractionEnabled:NO];
	return view;
}

#pragma mark - Cell Background Color
-(nullable UIColor*)cellBackroundColorForTableViewSection:(RDSCViewController_tableView_section)tableViewSection
{
	switch (tableViewSection)
	{
		case RDSCViewController_tableView_section_red:
			return [UIColor redColor];
			break;
			
		case RDSCViewController_tableView_section_green:
			return [UIColor greenColor];
			break;
			
		case RDSCViewController_tableView_section_blue:
			return [UIColor blueColor];
			break;
			
		case RDSCViewController_tableView_section_top_possiblyToggled:
		case RDSCViewController_tableView_section_top_toggle:
		case RDSCViewController_tableView_section_toggle:
		case RDSCViewController_tableView_section_possiblyToggled:
			return [UIColor whiteColor];
			break;
			
		case RDSCViewController_tableView_section_alwaysBottom:
			return [UIColor lightGrayColor];
			break;
	}
	
	NSAssert(false, @"unhandled");
	return nil;
}

#pragma mark - Cell Background Color
-(nullable NSString*)cellTextForTableViewSection:(RDSCViewController_tableView_section)tableViewSection
{
	switch (tableViewSection)
	{
		case RDSCViewController_tableView_section_top_possiblyToggled:
			return @"I am alive!";
			break;
			
		case RDSCViewController_tableView_section_top_toggle:
			return @"Tap to toggle the section above this one";
			break;
			
		case RDSCViewController_tableView_section_red:
		case RDSCViewController_tableView_section_green:
		case RDSCViewController_tableView_section_blue:
			return nil;
			break;
			
		case RDSCViewController_tableView_section_toggle:
			return @"Tap to toggle the section below this one";
			break;
			
		case RDSCViewController_tableView_section_possiblyToggled:
			return @"You've brought me to life!";
			break;
			
		case RDSCViewController_tableView_section_alwaysBottom:
			return @"Always bottom";
			break;
	}
	
	NSAssert(false, @"unhandled");
	return nil;
}

#pragma mark - top_toggled
-(void)setTop_toggled:(BOOL)top_toggled
{
	kRUConditionalReturn(self.top_toggled == top_toggled, NO);
	
	RDSCViewController_tableView_section const tableView_section = RDSCViewController_tableView_section_top_possiblyToggled;
	NSInteger indexPathSection_old = (self.top_toggled ?
									  [self.tableSectionManager indexPathSectionForSection:tableView_section] :
									  NSNotFound);
	
	_top_toggled = top_toggled;
	
	if (self.top_toggled)
	{
		[self.tableView insertSections:[NSIndexSet indexSetWithIndex:[self.tableSectionManager indexPathSectionForSection:tableView_section]]
					  withRowAnimation:UITableViewRowAnimationAutomatic];
	}
	else
	{
		[self.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPathSection_old]
					  withRowAnimation:UITableViewRowAnimationAutomatic];
	}
	
	[self tableSectionManager_validate];
}

#pragma mark - toggled
-(void)setToggled:(BOOL)toggled
{
	kRUConditionalReturn(self.toggled == toggled, NO);
	
	RDSCViewController_tableView_section const tableView_section = RDSCViewController_tableView_section_possiblyToggled;
	NSInteger indexPathSection_old = (self.toggled ?
									  [self.tableSectionManager indexPathSectionForSection:tableView_section] :
									  NSNotFound);
	
	_toggled = toggled;
	
	if (self.toggled)
	{
		[self.tableView insertSections:[NSIndexSet indexSetWithIndex:[self.tableSectionManager indexPathSectionForSection:tableView_section]]
					  withRowAnimation:UITableViewRowAnimationAutomatic];
	}
	else
	{
		[self.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPathSection_old]
					  withRowAnimation:UITableViewRowAnimationAutomatic];
	}
}

#pragma mark - tableSectionManager
-(void)tableSectionManager_validate
{
	NSAssert(self.tableSectionManager.firstAvailableSection ==
			 (self.top_toggled ?
			  RDSCViewController_tableView_section_top_possiblyToggled :
			  RDSCViewController_tableView_section_top_toggle), @"unhandled");
	
	RDSCViewController_tableView_section firstAvailableSection = self.tableSectionManager.firstAvailableSection;
	RDSCViewController_tableView_section lastAvailableSection = self.tableSectionManager.lastAvailableSection;
	
	NSInteger indexPathSection = 0;
	for (RDSCViewController_tableView_section section = firstAvailableSection;
		 section <= lastAvailableSection;
		 section++)
	{
		if ([self.tableSectionManager sectionDelegate_sectionIsAvailable:section])
		{
			NSAssert([self.tableSectionManager indexPathSectionForSection:section] == indexPathSection, @"section %li should match indexPathSection %li",section,indexPathSection);
			indexPathSection++;
		}
	}
}

@end
