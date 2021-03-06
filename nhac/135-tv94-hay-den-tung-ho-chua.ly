% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Hãy Đến Tung Hô Chúa" }
  composer = "Tv. 94"
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
  \partial 4 d8 d |
  b4 c8 c |
  a8. a16 a8 a |
  b4 g8 e |
  e4. d8 |
  b' b g g |
  a2 |
  r8 g e' e |
  c4 d8 d |
  b b a d |
  fs,4 g8 g |
  e4. d8 |
  a' a fs fs |
  g2 ~ |
  g4 r8 \bar "||"
  
  <<
    {
      \voiceOne
      g8
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \once \override NoteColumn.force-hshift = #2.5
      \tweak font-size #-2
      \parenthesize
      a
    }
  >>
  \oneVoice
  g8. g16 b (c) b8 |
  a4. fs8 |
  g8. a16 e (g) e8 |
  d4 r8 b16 d |
  g8 fs b16 (c) b8 |
  a4. fs16 a |
  g8 e fs e |
  d4 r8 d |
  g e16 e e8 e |
  e c'4 a8 |
  b4 r8 g |
  g g16 g c8 a |
  d d4 d8 |
  g,4 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  b8 b |
  g4 a8 a |
  fs8. fs16 fs8 fs |
  g4 e8 d |
  cs4. d8 |
  g g e e |
  d2 |
  r8 g c c |
  a4 b8 b |
  g g fs e |
  d4 e8 d |
  c4. b8 |
  c c d d |
  b2 ~ |
  b4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \stanzaReminderOff
  \set stanza = "ĐK:"
  Hãy đến đây cất tiếng ca,
  ta tung hô Chúa,
  Reo mừng Ngài là núi đá độ trì ta.
  Vào trước Thánh Nhan,
  hãy xướng lên muôn lời cảm tạ,
  Tung hô Ngài cùng với tiếng đàn lời ca.
  \stanzaReminderOn
  <<
    {
      \set stanza = "1."
      Vì Ngài là Chúa cao quang,
      Đại vương trổi vượt chư thần,
      Mọi vực sâu Ngài nắm trong tay,
      Mọi đỉnh cao Ngài giữ chủ quyền.
      Đại dương là của Ngài
      vì Ngài đã dựng nên,
      Lục địa thuộc về Chúa
      vì Chúa đã tác thành.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    \markup { \italic \underline "Hãy" }
	    vào phục bái suy tôn,
	    Quỳ đây trước thánh nhan Ngài,
	    Vì Ngài đà tạo tác nên ta,
	    Ngài vẫn luôn là Chúa ta thờ,
	    Còn ta là dòng tộc được Ngài thống trị luôn,
	    Cùng thuộc về đàn chiên mà Chúa vẫn dắt dìu.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Hôm nay nghe tiếng Chúa đi,
	    Lòng thôi cứng cỏi vô nghì,
	    Đừng như khi tại Mê -- ri -- ba,
	    Tại Mas -- sa, ở giữa sa mạc,
	    Tổ tiên họ đà từng nhiều lần dám thử Ta,
	    Dù rằng sự việc Ta họ chứng kiến rõ ràng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Miệt mài đà bốn mươi năm,
	    Làm Ta ngán ngẩm dân này,
	    Một đoàn dân lầm lỗi phiêu linh,
	    Đường lối Ta chẳng biết theo đòi,
	    Vậy Ta từng thịnh nộ thề rằng:
	    chúng đừng trông
	    Được vào mà nghỉ ngơi ở đất hứa phúc lộc.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2.5))
  ragged-bottom = ##t
}

TongNhip = {
  \key g \major \time 2/4
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
    \override Lyrics.LyricSpace.minimum-distance = #1.6
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
