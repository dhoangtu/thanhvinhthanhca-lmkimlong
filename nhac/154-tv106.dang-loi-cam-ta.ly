% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Dâng Lời Cảm Tạ" }
  composer = "Tv. 106"
  tagline = ##f
}

% mã nguồn cho những chức năng chưa hỗ trợ trong phiên bản lilypond hiện tại
% cung cấp bởi cộng đồng lilypond khi gửi email đến lilypond-user@gnu.org
% Đổi kích thước nốt cho bè phụ
notBePhu =
#(define-music-function (font-size music) (number? ly:music?)
   (for-some-music
     (lambda (m)
       (if (music-is-of-type? m 'rhythmic-event)
           (begin
             (set! (ly:music-property m 'tweaks)
                   (cons `(font-size . ,font-size)
                         (ly:music-property m 'tweaks)))
             #t)
           #f))
     music)
   music)

% in số phiên khúc trên mỗi dòng
#(define (add-grob-definition grob-name grob-entry)
     (set! all-grob-descriptions
           (cons ((@@ (lily) completize-grob-entry)
                  (cons grob-name grob-entry))
                 all-grob-descriptions)))

#(add-grob-definition
    'StanzaNumberSpanner
    `((direction . ,LEFT)
      (font-series . bold)
      (padding . 1.0)
      (side-axis . ,X)
      (stencil . ,ly:text-interface::print)
      (X-offset . ,ly:side-position-interface::x-aligned-side)
      (Y-extent . ,grob::always-Y-extent-from-stencil)
      (meta . ((class . Spanner)
               (interfaces . (font-interface
                              side-position-interface
                              stanza-number-interface
                              text-interface))))))

\layout {
    \context {
      \Global
      \grobdescriptions #all-grob-descriptions
    }
    \context {
      \Score
      \remove Stanza_number_align_engraver
      \consists
        #(lambda (context)
           (let ((texts '())
                 (syllables '()))
             (make-engraver
              (acknowledgers
               ((stanza-number-interface engraver grob source-engraver)
                  (set! texts (cons grob texts)))
               ((lyric-syllable-interface engraver grob source-engraver)
                  (set! syllables (cons grob syllables))))
              ((stop-translation-timestep engraver)
                 (for-each
                  (lambda (text)
                    (for-each
                     (lambda (syllable)
                       (ly:pointer-group-interface::add-grob
                        text
                        'side-support-elements
                        syllable))
                     syllables))
                  texts)
                 (set! syllables '())))))
    }
    \context {
      \Lyrics
      \remove Stanza_number_engraver
      \consists
        #(lambda (context)
           (let ((text #f)
                 (last-stanza #f))
             (make-engraver
              ((process-music engraver)
                 (let ((stanza (ly:context-property context 'stanza #f)))
                   (if (and stanza (not (equal? stanza last-stanza)))
                       (let ((column (ly:context-property context
'currentCommandColumn)))
                         (set! last-stanza stanza)
                         (if text
                             (ly:spanner-set-bound! text RIGHT column))
                         (set! text (ly:engraver-make-grob engraver
'StanzaNumberSpanner '()))
                         (ly:grob-set-property! text 'text stanza)
                         (ly:spanner-set-bound! text LEFT column)))))
              ((finalize engraver)
                 (if text
                     (let ((column (ly:context-property context
'currentCommandColumn)))
                       (ly:spanner-set-bound! text RIGHT column)))))))
      \override StanzaNumberSpanner.horizon-padding = 10000
    }
}

stanzaReminderOff =
  \temporary \override StanzaNumberSpanner.after-line-breaking =
     #(lambda (grob)
        ;; Can be replaced with (not (first-broken-spanner? grob)) in 2.23.
        (if (let ((siblings (ly:spanner-broken-into (ly:grob-original grob))))
              (and (pair? siblings)
                   (not (eq? grob (car siblings)))))
            (ly:grob-suicide! grob)))

stanzaReminderOn = \undo \stanzaReminderOff
% kết thúc mã nguồn

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \autoPageBreaksOff
  <> \tweak extra-offset #'(-5 . 0)
  ^\markup { \fontsize #1 \box \bold "Mở đầu" }
  a4. g16 a |
  bf4 \tuplet 3/2 { bf8 d c } |
  a2 |
  
  <> \tweak extra-offset #'(-2.5 . 0)
  ^\markup { \fontsize #1 \box \bold "A" }
  g4 \tuplet 3/2 { g8 a bf } |
  d,4 \tuplet 3/2 { c8 g' e } |
  f4 r8 \bar "||" \break
  
  f16 e |
  d4. d8 |
  c8. c16 \tuplet 3/2 { g'8 f e } |
  a4 \tuplet 3/2 { f8 g f } |
  e4 r8 d16 d |
  d8. d16 \tuplet 3/2 { g8 f g } |
  a4 \tuplet 3/2 { d8
    \afterGrace g,8 ({
      \override Flag.stroke-style = #"grace"
      a16)}
    \revert Flag.stroke-style
    a8 }
  
  \pageBreak
  
  bf4 \tuplet 3/2 { bf8
    \afterGrace e,8 ({
      \override Flag.stroke-style = #"grace"
      g16)}
    \revert Flag.stroke-style
    a8
  }
  <<
    {
      \voiceOne
      a4
      \tweak extra-offset #'(1 . -2) r8
      g
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \once \override NoteColumn.force-hshift = #1.2
      \tweak font-size #-2
      \parenthesize
      a2
    }
  >>
  \oneVoice
  f8. f16 \tuplet 3/2 { a8 f e } |
  d4 \tuplet 3/2 { d8 e c } |
  c4. f8 |
  d d4 f8 |
  g4 \tuplet 3/2 { bf8 g bf } |
  a4. f8 |
  a f4 e8 |
  d2 \bar "||" \break
  
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \set Staff.printKeyCancellation = ##f
  \key d \major
  <> \tweak extra-offset #'(-2.5 . 0)
  ^\markup { \fontsize #1 \box \bold "B" }
  a'8. gs16 a (b) a8 |
  fs4. d8 |
  a' a fs (a) |
  b4. a8 |
  d d cs (d) |
  e4. a,8 |
  fs' b,4 cs8 |
  \partial 4. d4 r8 \bar "||" \pageBreak
  
  \key f \major
  \partial 8 a16 f |
  e4 \tuplet 3/2 { g8 f \slashedGrace { f16 ( } g8) } |
  a4. a16 f |
  e4 \tuplet 3/2 { d8 f g } |
  g4 r8 g16 bf |
  a8. a16 \tuplet 3/2 { d8 e d } |
  cs4. cs16 d |
  bf8. bf16 \tuplet 3/2 { a8 e f } |
  \partial 4 d4 \bar "||" \break
  
  \key d \major
  \partial 8 a'8 |
  fs4. g8 |
  fs e4 a8 |
  d,4. d8 |
  d g4 fs8 |
  e4 r8 d |
  a' a fs (a) |
  b4 b16 (d) b8 |
  a4. e'8 |
  e fs4 cs8 |
  \stemDown d4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  f4. e16 f |
  g4 \tuplet 3/2 { g8 f e } |
  f2 |
  c4 \tuplet 3/2 { c8 c c } |
  bf4 \tuplet 3/2 { a8 bf c } |
  a4 r8
  
  r |
  R2*16
  
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \set Staff.printKeyCancellation = ##f
  \key d \major
  fs'8. e16 d8 [cs] |
  d4. d8 |
  cs cs d (fs) |
  g4. fs8 |
  b b a (b) |
  gs4. a8 |
  d g,4 a8 |
  fs4 r8
  
  r |
  R2*7
  r4
  
  \key d \major
  cs8 |
  d4. e8 |
  d cs4 cs8 |
  d4. d8 |
  c! b4 d8 |
  cs4 r8 d |
  cs cs d (fs) |
  g4 g16 (b) g8 |
  fs4. g8 |
  a a4 a8 |
  <fs d>4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  %\set stanza = "Mở đầu:"
  Hãy tạ ơn Chúa, vì Chúa nhân từ,
  Vì tình thương mến Ngài bền vững ngàn thu.
  <<
    {
      \set stanza = "1."
      Nói lên nào ai người được Chúa thương
      giải thoát khỏi tay quân thù,
      triệu tập về từ bao miền viễn xứ,
      khắp nẻo nam bắc, khắp nẻo đông tây,
      khi họ lạc bước trong sa mạc,
      không thấy đường về nơi thành thị an cư,
      Đói lả khát khô, tưởng đã như vong mạng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Có những người cam phận tàn kiếp trong ngục tối
	    xiềng xích gông cùm vì phản nghịch dể duôi lời Thiên Chúa,
	    dám dể khinh ý Chúa tể Muôn Cao,
	    nên Ngài để nếm bao khổ nhục năm tháng tàn lụi
	    bởi cực hình gian lao,
	    Ngã gục đớn đau chẳng có ai hộ phù.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Có những người điên dại vì mắc bao lầm lỗi nặng mang tội tình,
	    lòng buồn sầu của ăn đều chê chán,
	    đã tưởng lê bước tới cửa âm
	    \markup { \italic \underline "ty" }
	    \override Lyrics.LyricText.font-shape = #'italic
	    (qua B ngay)
	    \repeat unfold 22 { - }
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Có những người xuôi ngược vượt sóng khơi vạn lý
	    lèo lái con thuyền,
	    họ từng nhìn ngàn công việc tay Chúa,
	    thất đảm kinh hãi giữa biển mênh mông
	    khi Ngài để sóng đổ muôn trùng xô lấp thuyền họ,
	    nhấn chìm rồi tung lên,
	    Phách hồn thất kinh, và khéo khôn phiêu lạc.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Chúa đã làm sa mạc và đất khô thành suối,
	    thành bao sông ngòi, người nghèo hèn được đưa vào cư trú,
	    chúng đã xây cất phố thị khang trang,
	    gieo mạ và cấy nho trong vườn, con cháu đầy nhà,
	    gia cầm càng sinh sôi,
	    Bỗng lại héo hon vì vấp bao tai họa.
    }
  >>
  \set stanza = ""
  Khi gặp bước nguy nan,
  Họ kêu lên cùng Chúa,
  Ngài ra tay giải cứu,
  họ thoát cảnh gian truân.
  <<
    {
      \set stanza = "1."
      Dẫn họ về ngay đường thẳng lối
      Tới thị thành để họ an cư,
      Họng ráo khô Ngài cho uống phỉ tình,
      Bụng đói lả Chúa cho được no đầy.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Chúa bẻ gập gông cùm xiềng xích
	    Cứu họ khỏi ngục thẳm âm u,
	    Ngài phá tung kìa bao cánh cửa đồng
	    Và đã bẻ những then cài sắt này.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Chúa dủ tình sai Lời Ngài tới
	    Chữa họ lành và khỏi vong thân,
	    Nào hãy mau cùng dâng lễ cảm tạ
	    Và kể lại những công việc Chúa làm.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Chúa lại truyền cho biển lặng lẽ,
	    Bão tan rồi lòng họ an vui,
	    Ngài đưa thuyền về nơi bến mong chờ,
	    Từ công hội hãy dâng lời cảm tạ.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Chúa dủ tình cho người nghèo khó thoát tai nạn
	    được phồn vinh thêm,
	    người chính trực nhìn xem khấp khởi mừng,
	    Bọn ác độc ngước trông đành câm miệng.
    }
  >>
  \set stanza = ""
  Ước chi chúng dâng lời cảm tạ,
  vì tình Chúa bao la,
  vì uy công hiển hách Chúa đã làm cho con cái phàm nhân.
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 3\mm
  right-margin = 3\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  %page-count = 3
  system-system-spacing = #'((basic-distance . 0.1) (padding . 3))
  ragged-bottom = ##t
}

TongNhip = {
  \key f \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

\score {
  \new ChoirStaff <<
    \new Staff \with {
        \consists "Merge_rests_engraver"
        printPartCombineTexts = ##f
      }
      <<
      \new Voice \TongNhip \partCombine 
        \nhacPhienKhucSop
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    \override Lyrics.LyricSpace.minimum-distance = #0.6
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
