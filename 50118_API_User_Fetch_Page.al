page 50118 "API User Fetch Page"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    PageType = List;
    SourceTable = "Temporary User";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User ID"; Rec.Id) { }
                field("Name"; Rec.Name) { }
                field("Email"; Rec.Email) { }
                field("Username"; Rec.Username) { }

            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Fetch from API")
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    Fetcher: Codeunit "API User Fetcher";
                begin
                    Fetcher.FetchDataFromAPI();
                    CurrPage.Update();
                end;
            }
        }
    }
}