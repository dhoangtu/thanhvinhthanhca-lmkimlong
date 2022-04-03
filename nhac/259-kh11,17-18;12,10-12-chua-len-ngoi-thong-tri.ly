% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Chúa Lên Ngôi Thống Trị" }
  composer = "Kh. 11,17-18;12,10-12"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 8 d8 |
  b'2 ~ |
  b8 a d
  <<
    {
      \voiceOne
      fs,8
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \once \override NoteColumn.force-hshift = #-1.2
      \tweak font-size #-2
      \parenthesize
      a
    }
  >>
  \oneVoice
  g4 r8 b16 g |
  c8 a4
  <<
    {
      \voiceOne
      d8
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \once \override NoteColumn.force-hshift = #-1
      \tweak font-size #-2
      \parenthesize
      a
    }
  >>
  \oneVoice
  d4 r8 d |
  a8. a16 e (g) e8 |
  d4. a'16 g |
  fs8 fs a g |
  b8. a16 \tuplet 3/2 { c8 c d } |
  g,4 r8 \bar "||" \break
  
  <> \tweak extra-offset #'(-7.5 . -2.5) _\markup { \bold "ĐK:" }
  b |
  c8. c16 a8 d |
  g,4 r8 fs |
  g8. g16 g8 a |
  d,4 r8 d |
  b'4. a8 |
  b c d8. e16 |
  d8 b r a |
  c b a d |
  fs,8. fs16 a8 d, |
  g4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  r8 |
  R2*9
  r4.
  g8 |
  a8. g16 fs8 fs |
  g4 r8 d |
  e8. e16 e8 cs |
  d4 r8 d |
  g4. fs8 |
  g a b8. c16 |
  b8 g r fs |
  a g fs e |
  d8. d16 c8 c |
  b4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Lạy Chúa, Thiên Chúa toàn năng,
      Đấng hiện có và đã có,
      Chúng con xin cảm tạ Ngài
      Đã sử dụng quyền năng mạnh mẽ
      mà lên ngôi thống trị.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ngàn dân đã phẫn nộ lên,
	    Cơn giận Chúa liền trút xuống,
	    Chúa nay xét xử vong hồn,
	    Sẽ thưởng thọ bề tôi của Chúa
	    là bao Ngôn sứ Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Vì Chúa nay sẽ thưởng công
	    những người vốn thuộc
	    \markup { \italic \underline "về" } Chúa,
	    Những ai tôn sợ Danh Ngài,
	    Khắp thiên đình cùng chư thần thánh
	    hãy hân hoan hát mừng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Này chính quỷ dữ
	    \markup { \italic \underline "Sa" } -- tan,
	    Kẻ hằng cáo tội anh em,
	    Những anh em của ta này,
	    Cáo họ ngày ngày trước tòa Chúa
	    rầy bị đuổi ra ngoài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Họ đã vinh thắng vẻ vang,
	    Chính nhờ máu của Chiên Con,
	    Dám coi kinh cả sinh mạng,
	    Giữ bao lời làm chứng về Chúa
	    nguyện hy sinh đến cùng.
    }
  >>
  %\set stanza = "ĐK:"
  \set stanza = ""
  Thiên Chúa chúng ta kính thờ,
  giờ đây ban ơn cứu độ,
  giờ đây biểu dương uy dũng với vương quyền,
  và Đức Ki -- tô của Ngài tỏ rõ quyền năng.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2))
  page-count = 1
}

TongNhip = {
  \key g \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
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
     (padding . 1)
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
                      (ly:pointer-group-interface::add-grob text
'side-support-elements syllable))
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
% kết thúc mã nguồn

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
