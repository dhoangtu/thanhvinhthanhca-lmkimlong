% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Tôi Hân Hoan Vui Sướng" }
  composer = "Is. 60,10-62,5"
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
  a8. a16 a8 a |
  bf2 |
  g4. g8 |
  a2 |
  f8. g16 e8 d |
  c4 a'8 f |
  bf4. a8 |
  g4 r8 e |
  e8. g16 g8 g |
  a d,4 c8 |
  a'8. a16 bf8 a |
  g4 r8 c16 d |
  bf8 bf g bf |
  a4 r8 g16 g |
  g8 c, g' e |
  f2 \bar "|." \break
  
  g8. a16 d,8 g ~ |
  g g d e16 (d) |
  c2 |
  f8.
  <<
    {
      \voiceOne
      e16
    }
    \new Voice = "beSop" {
      \voiceTwo
      \stemDown
      \once \override NoteColumn.force-hshift = #-1.2
      \parenthesize
      f16
    }
  >>
  \oneVoice
  <<
    {
      \voiceOne
      e8
    }
    \new Voice = "beSop" {
      \voiceTwo
      \stemDown
      \once \override NoteColumn.force-hshift = #1.6
      \parenthesize
      g8
    }
  >>
  \oneVoice
  a ~ |
  a c d, d16 (f) |
  g4 r8 bf |
  
  \pageBreak
  
  bf8. bf16 g8
  <<
    {
      \voiceOne
      g8
    }
    \new Voice = "beSop" {
      \voiceTwo
      \stemDown
      \once \override NoteColumn.force-hshift = #-1.2
      \parenthesize
      a8
    }
  >>
  \oneVoice
  a4. bf8 |
  c4 r8 g16 g |
  a8
  <<
    {
      \voiceOne
      a8
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \once \override NoteColumn.force-hshift = #-2.7
      \tweak font-size #-2
      \parenthesize
      a16
      \once \override NoteColumn.force-hshift = #0.5
      %\tweak font-size #-2
      \parenthesize
      a16
    }
  >>
  \oneVoice
  e8 g |
  c,4 g'8 e |
  f2 \bar "||"
}

nhacPhienKhucAlto = \relative c' {
  f8. f16 f8 e |
  d2 |
  e4. e8 |
  f2 |
  f8. g16 e8 d |
  c4 f8 d |
  g4. f8 |
  c4 r8 e |
  e8. g16 g8 g |
  a d,4 c8 |
  f8. f16 g8 f |
  e4 r8 a16 bf |
  g8 g e g |
  f4 r8 bf,16 bf |
  c8 a bf c |
  a2 |
  
  g'8. a16 d,8 g ~ |
  g g d e16 (d) |
  c2 |
  f8.
  <<
    {
      \voiceOne
      e16
    }
    \new Voice = "beSop" {
      \voiceTwo
      \stemDown
      \once \override NoteColumn.force-hshift = #-1.2
      \parenthesize
      f16
    }
  >>
  \oneVoice
  <<
    {
      \voiceOne
      e8
    }
    \new Voice = "beSop" {
      \voiceTwo
      \stemDown
      \once \override NoteColumn.force-hshift = #1.6
      \parenthesize
      g8
    }
  >>
  \oneVoice
  a ~ |
  a c d, d16 (f) |
  g4 r8 g |
  g8. g16 e8
  <<
    {
      \voiceOne
      e8
    }
    \new Voice = "beSop" {
      \voiceTwo
      \stemDown
      \once \override NoteColumn.force-hshift = #-1.2
      \parenthesize
      f8
    }
  >>
  \oneVoice
  f4. g8 |
  a4 r8 e16 e |
  f8
  <<
    {
      \voiceOne
      f8
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \once \override Beam.transparent = ##t
      \once \override Stem.transparent = ##t
      \once \override NoteColumn.force-hshift = #-2.7
      \tweak font-size #-2
      \parenthesize
      f16
      \once \override Beam.transparent = ##t
      \once \override Stem.transparent = ##t
      \once \override NoteColumn.force-hshift = #0.5
      \tweak font-size #-2
      \parenthesize
      f16
    }
  >>
  \oneVoice
  d8 bf |
  a4 bf8 c |
  a2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \stanzaReminderOff
  \set stanza = "ĐK:"
  Tôi hân hoan vui sướng trong Thiên Chúa,
  Trong Đấng tôi tôn thờ,
  tôi mừng rỡ biết bao.
  Ngài mặc cho tôi ơn cứu độ,
  choàng cho tôi đức công minh
  Như chú rể chỉnh tề áo khăn,
  Như cô dâu lộng lẫy điểm trang.
  \stanzaReminderOn
  <<
    {
      \set stanza = "1."
      Như đất làm cho đâm chồi nảy lộc,
      Như vườn tược khiến nhú mầm trổ cây,
      Chúa cũng sẽ làm trổ hoa công chính,
      Làm trổi vang muôn lời ca ngợi trước ngàn dân.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Vì mến Si -- on tôi chẳng nín lặng,
	    Bởi chuộng \markup { \italic \underline "Gia" }
	    -- liêm lẽ nào ngủ yên
	    Tới lúc Đấng tựa hừng đông hiện đến,
	    Tựa ngọn đuốc \markup { \italic \underline "Đấng Cứu" } Độ
	    của thành sáng rực lên.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Muôn nước nhìn coi ngươi thực chính trực,
	    Bao vị hoàng đế ngắm hiển vinh ngươi
	    Khắp chốn sẽ gọi
	    \markup { \italic \underline "ngươi" } bằng tên mới,
	    thực là chính tên miệng Chúa Trời đã đặt cho.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Người sẽ trở nên mũ triều thiên vàng,
	    như ngọc miện quý Chúa cầm ở tay.
	    Quê ngươi chẳng còn là nơi hoang vắng,
	    Và chẳng sẽ ai gọi ngươi là “thứ bỏ đi”.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Ngươi sẽ được kêu: “Ái khanh Ta này”,
	    Quê \markup { \italic \underline "ngươi" }
	    được tiếng “đất đà đẹp duyên”.
	    Chúa sẽ ái mộ và thương ngươi mãi
	    Và sẽ kết ước tình yêu cùng xứ sở ngươi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Nào khác tài trai cưới tôn nữ về:
	    Đấng tạo thành ngươi kết bạn cùng ngươi.
	    Như tân nương làm tình quân vui sướng,
	    thì này ngươi cũng làm thỏa lòng Chúa Trời ngươi.
    }
  >>
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
  ragged-bottom = ##t
  system-system-spacing = #'((basic-distance . 0.1) (padding . 3))
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
    \override Lyrics.LyricSpace.minimum-distance = #1
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
